from glFB import Screen

type
  Window* = object
    res*: (int, int)
    scr*: Screen
  Axis* = enum
    X
    Y