from chroma import ColorRGBX
import glFB except Window
from types import Window

proc drawBackground* (w: var Window, colour: ColorRGBX = w.bg_colour) =
    for pix in w.scr.pixels(): pix = colour

proc drawRect* (w: var Window, pos: (int, int), size: (int, int), colour: ColorRGBX, condition: bool = true) =
    if condition == true:
      for x in pos[0]..pos[0]+size[0]:
        for y in pos[1]..pos[1]+size[1]:
          w.scr[x, y] = colour