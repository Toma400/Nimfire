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