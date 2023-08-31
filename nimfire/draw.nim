from chroma import ColorRGBX
import glFB except Window
from types import Window

proc drawBackground* (w: var Window, colour: ColorRGBX) =
    for pix in w.scr.pixels(): pix = colour

proc drawRect* (w: var Window, pos: (int, int), size: (int, int), colour: ColorRGBX) =
    for x in pos[0]..pos[0]+size[0]:
      for y in pos[1]..pos[1]+size[1]:
        w.scr[x, y] = colour