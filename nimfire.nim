from nimfire/draw import drawBackground
from nimfire/types import Window
from nimfire/colors import BLACK
from chroma import ColorRGBX
import glFB except Window
import vmath

proc initWindow* (res: (int, int), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window =
    #[ Creates initial Window object. Arguments:
    - res       : (int, int) | required        >> Resolution of the window
    - title     : string     | required        >> Title of the window
    - resizable : bool       | default = false >> Whether window should be resizeable
    - bg_colour : ColorRGBX  | default = BLACK >> Colour of the background ]#
    result.scr = Screen.new(res[0], res[1], title, resizable)
    result.bg_colour = bg_colour
    result.drawBackground()

#[ Returns tuple with window size (using GLFW function) ]#
proc getRes* (w: var Window): (int, int) =
    return (w.scr.win.getSize()[0].int, w.scr.win.getSize()[1].int)

#[ Let you manually clean canvas by drawing background over what was drawn ]#
proc clear* (w: var Window) =
    w.drawBackground()

#[ Returns whether Window is ticking - stops when exit event is called ]#
proc tick* (w: var Window): bool =
    return not w.scr.close()

#[ Updated the screen. Should be used on every 'tick(Window)' check ]#
proc update* (w: var Window) =
    w.scr.update()
    w.clear()

#[ Exits the application ]#
proc finish* (w: var Window) =
    w.scr.term()

#[ ALIASES ]#
proc ignite* (res: (int, int), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window = # initWindow()
    return initWindow(res, title, resizable, bg_colour)
proc isBurning* (w: var Window): bool = return w.tick()                                                        # tick()
proc addWood* (w: var Window) = w.update()                                                                     # update()
proc extinguish* (w: var Window) = w.finish()                                                                  # finish()