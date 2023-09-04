from pixie/fileformats/png import decodePng, encodePng, Png
from pixie import autoPremultipliedAlpha
from chroma import ColorRGBA, ColorRGBX
from ../nimfire import isWithin
import glFB except Window
from types import Window
import std/tables
import std/syncio

proc createMatrix* (res: (int, int), pxs: seq[ColorRGBA]):        OrderedTable[(int, int), ColorRGBX]
proc filterMatrix* (matrix: OrderedTable[(int, int), ColorRGBX]): OrderedTable[(int, int), ColorRGBX]

type
  Image* = object
    png*    : Png         # pixie Png object
    pos*    : (int, int)  # 'pos' can be declared in drawing to overwrite
    res*    : (int, int)
    matrix* : OrderedTable[(int, int), ColorRGBX] # full pixel matrix, table of [coords, color_value]
    fatrix* : OrderedTable[(int, int), ColorRGBX] # filtered matrix, does not have transparent pixels

proc newImage* (path: string, pos: (int, int) = (0, 0)): Image =
    result.pos = pos
    result.png = decodePng(readFile(path)) # returns pixie.Png type
    result.res = (result.png.width, result.png.height)
    result.matrix = createMatrix(result.res, result.png.data)
    result.fatrix = filterMatrix(result.matrix)
#[ Returns ending pos for Image as (X, Y) tuple ]#
proc epos* (i: Image): (int, int) =
    return (i.pos[0]+i.res[0],
            i.pos[1]+i.res[1])

proc drawImage* (w: var Window, i: Image, pos: (int, int) = i.pos, cond: bool = true) =
    var x, y: int
    if cond == true:
      for k, v in i.fatrix:
        x = pos[0]+k[0]
        y = pos[1]+k[1]
        if isWithin(w, (x, y)):
          w.scr[x, y] = v

#[ Simple QoL function for moving Image with tuple or ints (use negative ints to substract) ]#
proc move* (i: var Image, pos: (int, int)) =
    i.pos = (i.pos[0] + pos[0], i.pos[1] + pos[1])
proc move* (i: var Image, x: int, y: int) =
    move(i, (x, y))
#[ Checks if specific position collides with Image given ]#
#[ Have in mind that it checks for rectangle shape,
                       including transparent pixels ]#
proc collide* (i: Image, pos: (int, int)): bool =
    if i.pos[0] < pos[0] and pos[0] < i.epos[0]:
      if i.pos[1] < pos[1] and pos[1] < i.epos[1]:
        return true
    return false
proc collide* (i: Image, x: int, y: int): bool =
    return collide(i, (x, y))
#[ Checks if Image (i2) collides with another Image (i) ]#
#[ Have in mind that it checks for rectangle shape,
                       including transparent pixels ]#
proc collide* (i: Image, i2: Image): bool =
    if collide(i, (i2.pos[0], i2.pos[1])):
      if collide(i, (i2.pos[0]), i2.epos[1]):
        if collide(i, (i2.epos[0], i2.pos[1])):
          if collide(i, (i2.epos[0], i2.epos[1])):
            return true
    return false

#[ Checker similar to 'collide' above, but only for pixels
   that are not transparent.
   Takes image shape into consideration instead of
   performing collision check on rectangular shape.
   Should be used with caution being more performance-heavy,
   especially Rect comparison one                         ]#
proc collidePrecise* (i: Image, pos: (int, int)): bool =
    # creates current (non-relative) pos tuple
    proc u(c: (int, int), p: (int, int)): (int, int) =
      return (c[0] + p[0], c[1] + p[1])

    for coord, _ in i.fatrix:
      if u(coord, i.pos) == pos: return true
    return false
proc collidePrecise* (i: Image, x: int, y: int): bool =
    return collidePrecise(i, (x, y))
proc collidePrecise* (i: Image, i2: Image): bool =
    # creates current (non-relative) pos tuple
    proc u(c: (int, int), p: (int, int)): (int, int) =
      return (c[0] + p[0], c[1] + p[1])

    for coord, _ in i.fatrix:
      for coord2, _ in i2.fatrix:
        if u(coord, i.pos) == u(coord2, i2.pos): return true
    return false

#[ Checks if Image is within screen range ]#
proc isWithin* (i: Image, w: var Window): bool =
    if isWithin(w, (i.pos[0], i.pos[1])):
      if isWithin(w, (i.pos[0], i.epos[1])):
        if isWithin(w, (i.epos[0], i.pos[1])):
          if isWithin(w, (i.epos[0], i.epos[1])):
            return true
    return false

proc createMatrix* (res: (int, int), pxs: seq[ColorRGBA]): OrderedTable[(int, int), ColorRGBX] =
    var x = 0
    var y = 0
    for px in pxs:
      result[(x, y)] = autoPremultipliedAlpha(px) # converts RGBA into RGBX and binds to coords
      if x < res[0]-1:
        x += 1
      else:
        x = 0; y += 1

#[ Filters base matrix out of transparent pixels ]#
proc filterMatrix* (matrix: OrderedTable[(int, int), ColorRGBX]): OrderedTable[(int, int), ColorRGBX] =
    for k, v in matrix:
      if v.a > 0:
        result[k] = v

proc saveImage* (i: Image, name: string) =
    let ret = open(name, fmWrite)
    defer: ret.close()
    write(ret, encodePng(i.png))

#[ Creates new empty ImageHandler ]#
# proc newImageHandler* (): ImageHandler =
#     result.h = newTable[string, Image]
#[ Let you register Image in ImageHandler ]#
# proc registerImage* (h: var ImageHandler, i: Image, id: string) =
#     h[id] = i
#[ Alias for newImage that let you register Image into Handler in the same time ]#
# proc newImage* (h: var ImageHandler, path: string, id: string): Image =
#     result = newImage(path)
#     registerImage(h, id, result)
#[ Alias for drawImage that uses Handler instead of raw Window ]#
#TODO: requires using either Window in Handler, or bind Handler to Window
# proc drawImage* (h: var ImageHandler, id: string, pos: (int, int)) =
#     drawImage(h.win, h[id], pos)