from chroma import ColorRGBX
import glFB except Window
from types import Window

type
  Rect* = object
    pos*    : (int, int)
    size*   : (int, int)
    colour* : ColorRGBX
proc newRect* (pos: (int, int), size: (int, int), colour: ColorRGBX): Rect =
    return Rect(pos: pos, size: size, colour: colour)
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
#[ Check if Rect (r2) collides with another Rect (r) ]#
proc collide* (r: Rect, r2: Rect): bool =
    for x in r2.pos[0]..r2.epos[0]:
      for y in r2.pos[1]..r2.epos[1]:
        return collide(r, (x, y))

#[ Draws one colour on whole screen ]#
proc drawBackground* (w: var Window, colour: ColorRGBX = w.bg_colour) =
    for pix in w.scr.pixels(): pix = colour

#[ Regular drawRect, using manually set position, size and colour ]#
proc drawRect* (w: var Window, pos: (int, int), size: (int, int), colour: ColorRGBX, condition: bool = true) =
    if condition == true:
      for x in pos[0]..pos[0]+size[0]:
        for y in pos[1]..pos[1]+size[1]:
          w.scr[x, y] = colour

#[ Alternative drawRect using predefined type for faster implementation ]#
proc drawRect* (w: var Window, r: var Rect, condition: bool = true) =
    if condition == true:
      for x in r.pos[0]..r.pos[0]+r.size[0]:
        for y in r.pos[1]..r.pos[1]+r.size[1]:
          w.scr[x, y] = r.colour