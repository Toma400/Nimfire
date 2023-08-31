from nimfire/colors import BLACK
from chroma import ColorRGBX
import glFB

type
  Window = object
    res: (int, int)
    scr: Screen

proc drawBackground* (w: var Window, colour: ColorRGBX)

proc initWindow* (res: (int, int), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window =
    #[ Creates initial Window object. Arguments:
    - res       : (int, int) | required        >> Resolution of the window
    - title     : string     | required        >> Title of the window
    - resizable : bool       | default = false >> Whether window should be resizeable
    - bg_colour : ColorRGBX  | default = BLACK >> Colour of the background ]#
    result.res = res
    result.scr = Screen.new(res[0], res[1], title, resizable)
    result.drawBackground(bg_colour)

proc drawBackground* (w: var Window, colour: ColorRGBX) =
    for pix in w.scr.pixels(): pix = colour

proc drawRect* (w: var Window, pos: (int, int), size: (int, int), colour: ColorRGBX) =
    for x in pos[0]..pos[0]+size[0]:
      for y in pos[1]..pos[1]+size[1]:
        w.scr[x, y] = colour

proc tick* (w: var Window): bool =
    return not w.scr.close()

proc update* (w: var Window) =
    w.scr.update()

proc finish* (w: var Window) =
    w.scr.term()

#[ ALIASES ]#
proc ignite* (res: (int, int), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window =
    return initWindow(res, title, resizable, bg_colour)
proc isBurning* (w: var Window): bool = return w.tick()
proc addWood* (w: var Window) = w.update()
proc extinguish* (w: var Window) = w.finish()