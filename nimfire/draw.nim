from ../nimfire import isWithin, fillBackground
from chroma/transformations import rgba
from chroma import ColorRGBX, ColorRGBA
from pixie/fileformats/png import Png
import glFB except Window
from types import Window
from image import Image
import std/tables

proc createMatrix* (s: (int, int), e: (int, int), c: ColorRGBX): Table[(int, int), ColorRGBX]

type
  Rect* = object
    pos*    : (int, int)
    size*   : (int, int)
    colour* : ColorRGBX
    matrix* : Table[(int, int), ColorRGBX]
proc newRect* (pos: (int, int), size: (int, int), colour: ColorRGBX): Rect =
    result.pos    = pos
    result.size   = size
    result.colour = colour
    result.matrix = createMatrix(pos, (pos[0]+size[0], pos[1]+size[1]), colour)
#[ Returns ending pos for Rect as (X, Y) tuple ]#
proc epos* (r: Rect): (int, int) =
    return (r.pos[0]+r.size[0],
            r.pos[1]+r.size[1])
#[ Simple QoL function for moving rectangle with tuple or ints (use negative ints to substract) ]#
proc move* (r: var Rect, pos: (int, int)) =
    r.pos = (r.pos[0] + pos[0], r.pos[1] + pos[1])
proc move* (r: var Rect, x: int, y: int) =
    move(r, (x, y))
#[ Checks if specific position collides with Rect given ]#
proc collide* (r: Rect, pos: (int, int)): bool =
    for x in r.pos[0]..r.epos[0]:
      for y in r.pos[1]..r.epos[1]:
        if (x, y) == pos: return true
    return false
proc collide* (r: Rect, x: int, y: int): bool =
    return collide(r, (x, y))
#[ Checks if Rect (r2) collides with another Rect (r) ]#
proc collide* (r: Rect, r2: Rect): bool =
    for x in r2.pos[0]..r2.epos[0]:
      for y in r2.pos[1]..r2.epos[1]:
        if collide(r, (x, y)) == true: return true
    return false
#[ Checks if Rect is within screen range ]#
proc isWithin* (r: Rect, w: var Window): bool =
    if isWithin(w, (r.pos[0], r.pos[1])):
      if isWithin(w, (r.pos[0], r.epos[1])):
        if isWithin(w, (r.epos[0], r.pos[1])):
          if isWithin(w, (r.epos[0], r.epos[1])):
            return true
    return false

#[ Draws one colour on whole screen ]#
proc drawBackground* (w: var Window, colour: ColorRGBX = w.bg_colour) =
    fillBackground(w, colour)

#[ Regular drawRect, using manually set position, size and colour ]#
proc drawRect* (w: var Window, pos: (int, int), size: (int, int), colour: ColorRGBX, condition: bool = true) =
    if condition == true:
      for x in pos[0]..pos[0]+size[0]:
        for y in pos[1]..pos[1]+size[1]:
          if isWithin(w, (x, y)) and colour.a > 0:
            w.scr[x, y] = colour

#[ Alternative drawRect using predefined type for faster implementation ]#
proc drawRect* (w: var Window, r: var Rect, condition: bool = true) =
    var x, y: int
    if condition == true:
      for k, v in r.matrix:
        x = r.pos[0]+k[0]
        y = r.pos[1]+k[1]
        if isWithin(w, (x, y)):
          w.scr[x, y] = v

#[ Creates matrix for further pixel manipulation ]#
proc createMatrix* (r: var Rect): Table[(int, int), ColorRGBX] =
    var ex, ey: int
    for x in r.pos[0]..r.epos[0]-1:
      for y in r.pos[1]..r.epos[1]-1:
        ex = x-r.pos[0]
        ey = y-r.pos[1]
        result[(ex, ey)] = r.colour
# raw variant for Rect initialisation
proc createMatrix* (s: (int, int), e: (int, int), c: ColorRGBX): Table[(int, int), ColorRGBX] =
    var ex, ey: int
    for x in s[0]..e[0]-1:
      for y in s[1]..e[1]-1:
        ex = x-s[0]
        ey = y-s[1]
        result[(x, y)] = c

#[ QoL wrapper for Rect.fatrix[(x, y)] = pix ]#
proc setPixel* (r: var Rect, pos: (int, int), colour: ColorRGBX) =
    r.matrix[(pos[0], pos[1])] = colour
proc setPixel* (r: var Rect, x: int, y: int, colour: ColorRGBX) =
    r.matrix[(x, y)] = colour
#[ Resets changes made by setPixel to base colour of Rect ]#
proc clearPixels* (r: var Rect) =
    for k, v in r.matrix:
      r.matrix[k] = r.colour
#[ Changes colour of rectangle. Should not be performed often, as it recreates matrix ]#
proc setColour* (r: var Rect, colour: ColorRGBX) =
    r.colour = colour
    r.matrix = createMatrix(r)

#[ Converts Rect into Image ]#
proc toImage* (r: Rect): Image =
    proc getData(m: Table[(int, int), ColorRGBX]): seq[ColorRGBA]=
      for cor, col in m:
        result.add(rgba(col))

    result.pos = r.pos
    result.png = Png(width: r.size[0], height: r.size[1], channels: 1, data: getData(r.matrix)) # returns pixie.Png type
    result.res = r.size
    result.matrix = r.matrix
    result.fatrix = r.matrix

#[ TODO: I guess we could convert it both ways? ]#
proc toRect (i: Image): Rect =
    discard