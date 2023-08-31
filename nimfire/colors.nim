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
  BLUE*   = r(  0,   0, 255)
  RED*    = r(255,   0,   0)
  YELLOW* = r(255, 255,   0)
  PURPLE* = r(128,   0, 128)
  # BROWN
  CYAN*   = r(  0, 255, 255)
  LIME*   = r(  0, 255,   0)
  CREAM*  = r(239, 230, 198)
  PINK*   = r(255, 192, 203)

  #[ White-like shades ]#

  #[ Black-like shades ]#

  #[ Green-like shades ]#
  OLIVE_GREEN*  = r(181, 179,  92)
  MORNING_BLUE* = r(141, 163, 153) # -- gray-driven / cyan-driven
  PINE_GREEN*   = r(  1, 121, 111) # -- cyan-driven:blue
  ##### CATS # -- bright | bleak, dark, cyan-driven:green, creamy-driven, gray-driven
  #[ Blue-like shades ]#
  NAVY_BLUE* = r(  0,  0, 128) # -- dark
  DARK_NAVY* = r(  2,  7,  93)
  #[ Red-like shades ]#
  ALABAMA_CRIMSON* = r(175,   0,  42)
  MAROON*          = r(128,   0,   0)
  CLARET*          = r(100,  29,  47)
  BLOOD*           = r(138,   3,   3) # -- dark
  #[ Yellow-like shades ]#

  #[ Purple-like shades ]#

  # [Brown-like shades ]#
  COMEX_CAOBA* = r(136,  66,  29) # -- classic
  CHOCOLATE*   = r(123,  63,   0)
  ACAJOU*      = r( 76,  47,  39) # -- dark
  BAIKO*       = r(133, 124,  85) # -- gray-driven
  IWAI*        = r( 94,  85,  69)
  #[ Cyan-like shades ]#
  AQUA*       = r(  0, 255, 255) # -- bright
  AQUAMARINE* = r(127, 255, 212)
  TEAL*       = r(  0, 128, 128) # -- teal-like
  #[ Lime-like shades ]#

  #[ Pink-like shades ]#
  CHINESE_PINK*  = r(222, 112, 161) # -- purple-like
  AMERICAN_PINK* = r(255, 152, 153) # -- pastel
  BARBIE_PINK*   = r(233,  65, 150)

proc toRGBX* (tup: (uint8, uint8, uint8, uint8)): ColorRGBX =
    result = rgbx(tup[0], tup[1], tup[2], tup[3])

proc toRGBX* (hex: string): ColorRGBX =
    result = parseHexAlpha(hex).asRgbx()