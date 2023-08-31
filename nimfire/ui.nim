from chroma import ColorRGBX, rgbx
from types import Window
from draw import drawRect

{.push experimental.}
type
  Button* = object
    pos*:          (int, int)
    size*:         (int, int)
    text*:         string
    frame_border*: (int, int)
    col_button*:   ColorRGBX
    col_border*:   ColorRGBX

proc newButton* (pos        : (int, int),
                 size       : (int, int),
                 text       : string     = "",
                 button_col : ColorRGBX,
                 border     : (int, int) = (0, 0), # use 'pax' or 'pay' if you want borders to look equally w/o manual adjustment (nimfire/utils)
                 border_col : ColorRGBX  = rgbx(0, 0, 0, 0)): Button =
    #[ Creates new Button object. Arguments:
    - pos        : (int, int) | required         >> Initial position of the button
    - size       : (int, int) | required         >> Size of the button (whole)
    - text       : string     | default = ""     >> Text written on button
    - button_col : ColorRGBX  | required         >> Colour of the button (see nimfire/colors)
    - border     : (int, int) | default = (0, 0) >> Creates frame between button inside and border
    - border_col : ColorRGBX  | default = INV    >> Colour of the border (default is invisible) ]#

    result.pos  = pos
    result.size = size
    result.text = text
    result.col_button = button_col
    result.col_border = border_col
    result.frame_border = border
#
# proc assignButton* (b: Button, id: string) =
#     b.window.buttons.add(id, b) # can they be inside each other? wouldn't it make more sense to have some ref for Window in Button, but exact
#                                 # object in Window?

# -- in nimfire.nim
# proc getButton* (w: var Window, s: string): Button =
#     return w.buttons[s]

# other option: no bound window for Button (as it was funky as you saw with issues of recursivity), then maybe there should be call from
# Window object? Like 'draw Button (var Window, ID <str>)' which would browse buttons
# ISSUE - recursivity is still made (because ui.nim uses Window for type checking), but is not practically wrong (no type recursivity)
#          --- example of shorthand proc ---
# proc drawButton* (w: var Window, id: string, condition: bool = true) =
#     if condition == true:
#       ...
#       operateOnButton: w.buttons[id]
#
# this would also allow for interesting multi-draw:
#
# proc drawButtons* (w: var Window, exclude: varargs[Button]) =
#     for _, button in w.buttons:
#       if button not in exclude:
#         w.drawButton(button)
#
# Additionally, it'd be nice to have button that takes image instead of drawing it by itself

# Changes position of button by replacing its position (absolute)
proc moveButtonAbs* (b: var Button, new_pos: (int, int)) =
    b.pos = new_pos

# Changes position of button by moving by specific length (relatively)
proc moveButton* (b: var Button, pos: (int, int)) =
    b.pos = (b.pos[0] + pos[0], b.pos[1] + pos[1])

proc drawButton* (w: var Window, b: Button, condition: bool = true) =
    if condition == true:
      if b.frame_border > (0, 0):
          drawRect(w, b.pos, b.size, b.col_border)
          drawRect(w,                                # window
                   (b.pos[0]+b.frame_border[0],      # position
                    b.pos[1]+b.frame_border[1]),
                   (b.size[0]-(b.frame_border[0]*2), # size
                    b.size[1]-(b.frame_border[1]*2)),
                   b.col_button)                     # colour
      else:
          drawRect(w, b.pos, b.size, b.col_button)

{.pop.}