from chroma import ColorRGBX, rgbx
from types import Window
from draw import drawRect


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
                 text       : string,
                 button_col : ColorRGBX,
                 border     : (int, int) = (0, 0), # use 'pax' or 'pay' if you want borders to look equally w/o manual adjustment (nimfire/utils)
                 border_col : ColorRGBX  = rgbx(0, 0, 0, 0)): Button =
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