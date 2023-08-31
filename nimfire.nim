from nimfire/draw import drawBackground
from nimfire/types import Window
from nimfire/colors import BLACK
from chroma import ColorRGBX
import glFB except Window

proc initWindow* (res: (int, int), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window =
    #[ Creates initial Window object. Arguments:
    - res       : (int, int) | required        >> Resolution of the window
    - title     : string     | required        >> Title of the window
    - resizable : bool       | default = false >> Whether window should be resizeable
    - bg_colour : ColorRGBX  | default = BLACK >> Colour of the background ]#
    result.res = res # use gl*FB handler if possible
    result.scr = Screen.new(res[0], res[1], title, resizable)
    result.bg_colour = bg_colour
    result.drawBackground()

# should be updated to use gl*FB 'getSize' as it is more reliable than w.res
proc getSize* (w: var Window): (int, int) {.deprecated.} =
    return w.res

proc tick* (w: var Window): bool =
    return not w.scr.close()

proc update* (w: var Window) =
    # if w.bg_colour != BLACK:
    #     w.drawBackground() # clears the window
    w.scr.update()

proc finish* (w: var Window) =
    w.scr.term()

#[ ALIASES ]#
proc ignite* (res: (int, int), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window =
    return initWindow(res, title, resizable, bg_colour)
proc isBurning* (w: var Window): bool = return w.tick()
proc addWood* (w: var Window) = w.update()
proc extinguish* (w: var Window) = w.finish()