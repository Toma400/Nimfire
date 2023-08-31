from chroma import rgbx, ColorRGBX, parseHexAlpha
from chroma/transformations import asRgbx

# utility procedure for colours below
proc r(r: uint8, g: uint8, b: uint8): ColorRGBX =
    return rgbx(r, g, b, 255)

const
  #[ Standard colours, based on HTML colour wheel ]#
  WHITE*  = r(255, 255, 255)
  BLACK*  = r(  0,   0,   0)
  GREEN*  = r(  0, 192,   0)
  # BLUE
  RED*    = r(255,   0,   0)
  YELLOW* = r(255, 255,   0)
  PURPLE* = r(128,   0, 128)
  # BROWN
  CYAN*   = r(  0, 255, 255)
  LIME*   = r(  0, 255,   0)
  # PINK

  #[ White-like shades ]#

  #[ Black-like shades ]#

  #[ Green-like shades ]#
  ##### CATS # -- bright | bleak, dark, cyan-driven:blue/green, creamy-driven, gray-driven
  #[ Blue-like shades ]#

  #[ Red-like shades ]#
  MAROON*  = r(128,   0,   0)
  CLARET*  = r(100,  29,  47)
  #[ Yellow-like shades ]#

  #[ Purple-like shades ]#

  # [Brown-like shades ]#
  COMEX_CAOBA* = r(136,  66,  29) # -- classic
  ACAJOU*      = r( 76,  47,  39) # -- dark
  #[ Cyan-like shades ]#
  AQUA* = r(  0, 255, 255) # -- bright
  TEAL* = r(  0, 128, 128) # -- teal-like
  #[ Lime-like shades ]#

  #[ Pink-like shades ]#
  FUCHSIA* = r(255,   0, 255)

proc toRGBX* (tup: (uint8, uint8, uint8, uint8)): ColorRGBX =
    result = rgbx(tup[0], tup[1], tup[2], tup[3])

proc toRGBX* (hex: string): ColorRGBX =
    result = parseHexAlpha(hex).asRgbx()