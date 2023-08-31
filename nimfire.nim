from chroma import ColorRGBX
import glFB

type
  Window = object
    res: (uint, uint)
    scr: Screen

proc drawBackground* (w: var Window, colour: ColorRGBX)

proc toRGBX* (tup: (uint8, uint8, uint8, uint8)): ColorRGBX =
    result = rgbx(tup[0], tup[1], tup[2], tup[3])

proc initWindow* (res: (uint, uint), title: string, resizable: bool = false, bg_colour: ColorRGBX = BLACK): Window =
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

# proc tick (w: var Window, procs: varargs[proc]) =
#     while not w.scr.close():
#       w.scr.update()
#       for pr in procs:
#         pr()

# proc run* (w: var Window, tick_procs: varargs[proc]) =
#     while not w.scr.close():
#       w.tick(tick_procs)
#     w.scr.term

proc drawRect* (w: var Window, pos: (int, int), size: (uint, uint), colour: ColorRGBX) =
    for x in pos[0]..pos[0]+size[0]:
      for y in pos[1]..pos[1]+size[1]:
        w.scr[x, y] = colour

proc tick (w: var Window) =
    while not w.scr.close():
      w.scr.update()
      w.drawRect((0, 0), (150, 150), BLACK)

proc run* (w: var Window) =
    while not w.scr.close():
      w.tick()
    w.scr.term()

# while not w.scr.close():                        # Run while the Screen has not been marked for closing
#   w.scr.update()                                # Update the screen contents in the GPU
# w.scr.term()                                    # Terminate everything after

# type Screen = object
#     srf: ptr Surface
#     ctx: ptr Context
#
# proc init* (size: pair[int, int]): Screen =
#     # creating context object
#     result.srf = imageSurfaceCreate(FORMAT_ARGB32, size.first, size.second)
#     result.ctx = result.srf.create()
#
# proc drawImage* (screen: ptr Screen, img: str, pos: pair[int, int]) =
#     screen.ctx.setSource(image, pos.first, pos.second)
#
# var scr = init((800, 600).toPair)
# scr.drawImage("vi.jpg", (0, 0).toPair)

#
# var scr = init((800, 600).toPair)       # Initialize the Screen object
# while not scr.close():                  # Run while the Screen has not been marked for closing
#   for pix in scr.pixels: pix = myPixel  # Generate the pixels on the CPU
#   scr.update()                          # Update the screen contents in the GPU
# scr.term()                              # Terminate everything after