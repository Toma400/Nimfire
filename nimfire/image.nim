from pixie/fileformats/png import decodePng, Png
from pixie import autoPremultipliedAlpha
from chroma import ColorRGBA, ColorRGBX
from ../nimfire import isWithin
import glFB except Window
from types import Window
import std/tables
import std/syncio

proc createMatrix* (res: (int, int), pxs: seq[ColorRGBA]): Table[(int, int), ColorRGBX]

type
  Image* = object
    png     : Png         # pixie object (private)
    pos*    : (int, int)  # 'pos' can be declared in drawing to overwrite
    res*    : (int, int)
    matrix* : Table[(int, int), ColorRGBX]
  # ImageHandler* = object
  #   h       : Table[string, Image]

proc newImage* (path: string, pos: (int, int) = (0, 0)): Image =
    result.pos = pos
    result.png = decodePng(readFile(path)) # returns pixie.Png type
    result.res = (result.png.width, result.png.height)
    result.matrix = createMatrix(result.res, result.png.data)
    echo(result.png.data)
#[ Returns ending pos for Image as (X, Y) tuple ]#
proc epos* (i: Image): (int, int) =
    return (i.pos[0]+i.res[0],
            i.pos[1]+i.res[1])

proc drawImage* (w: var Window, i: Image, pos: (int, int) = i.pos, cond: bool = true) =
    var x, y: int
    if cond == true:
      for k, v in i.matrix:
        x = pos[0]+k[0]
        y = pos[1]+k[1]
        if isWithin(w, (x, y)):
          w.scr[x, y] = v

#[ Simple QoL function for moving Image with tuple or ints (use negative ints to substract) ]#
proc move* (i: var Image, pos: (int, int)) =
    i.pos = (i.pos[0] + pos[0], i.pos[1] + pos[1])
proc move* (i: var Image, x: int, y: int) =
    move(i, (x, y))
#[ Checks if Image is within screen range ]#
proc isWithin* (i: Image, w: var Window): bool =
    if isWithin(w, (i.pos[0], i.pos[1])):
      if isWithin(w, (i.pos[0], i.epos[1])):
        if isWithin(w, (i.epos[0], i.pos[1])):
          if isWithin(w, (i.epos[0], i.epos[1])):
            return true
    return false

proc createMatrix* (res: (int, int), pxs: seq[ColorRGBA]): Table[(int, int), ColorRGBX] =
    var x = 0
    var y = 0
    for px in pxs:
      result[(x, y)] = autoPremultipliedAlpha(px) # converts RGBA into RGBX and binds to coords
      if y == 0: echo px
      if x < res[0]:
        x += 1
      else:
        x = 0; y += 1

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