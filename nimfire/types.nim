from chroma import ColorRGBX
from glFB import Screen

type
  Window* = object
    res*       : (int, int)
    scr*       : Screen
    bg_colour* : ColorRGBX
  Axis* = enum
    X
    Y