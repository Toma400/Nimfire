from pixie/fileformats/png import decodePng
from nglfw import GlfwImage, setWindowIcon
from nimfire/types import Window
from nimfire/colors import BLACK
from chroma import ColorRGBX
import glFB except Window
import vmath

#[ Forward functions]#
proc fillBackground* (w: var Window, colour: ColorRGBX = w.bg_colour)

proc initWindow* (res: (int, int), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window =
    #[ Creates initial Window object. Arguments:
    - res       : (int, int) | required        >> Resolution of the window
    - title     : string     | required        >> Title of the window
    - resizable : bool       | default = false >> Whether window should be resizeable
    - bg_colour : ColorRGBX  | default = BLACK >> Colour of the background            ]#
    result.scr = Screen.new(res[0], res[1], title, resizable)
    result.bg_colour = bg_colour
    result.fillBackground()

#[ Returns tuple with current window size (using GLFW function). Use over `res` field ]#
proc getRes* (w: Window): (int, int) =
    return (w.scr.win.getSize()[0].int, w.scr.win.getSize()[1].int)

#[ Checks whether specific coordinates are within window ]#
proc isWithin* (w: var Window, pos: (int, int)): bool =
    return (
      (-1 < pos[0] and pos[0] < getRes(w)[0]) and (-1 < pos[1] and pos[1] < getRes(w)[1])
    )

#[ Draws one colour on whole screen ]#
proc fillBackground* (w: var Window, colour: ColorRGBX = w.bg_colour) =
    for pix in w.scr.pixels(): pix = colour

#[ Draws on specific coordinates - alias for gl*FB <scr[x, y] = c> ]#
proc fillPos* (w: var Window, pos: (int, int), colour: ColorRGBX) =
    if isWithin(w, pos):
        w.scr[pos[0], pos[1]] = colour

#[ Let you manually clean canvas by drawing background over what was drawn ]#
proc clear* (w: var Window) =
    w.fillBackground()

#[ Returns whether Window is ticking - stops when exit event is called ]#
proc tick* (w: var Window): bool =
    return not w.scr.close()

#[ Updates the screen. Should be used on every 'tick(Window)' check. Arguments:
    - manual : bool | default = false >> Decide on whether you control clearing
                                         of window by yourself or this proc     ]#
proc update* (w: var Window, manual: bool = false) =
    w.scr.update()
    if not manual:
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