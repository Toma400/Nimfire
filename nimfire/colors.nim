from chroma import rgbx, ColorRGBX, parseHexAlpha
from chroma/transformations import asRgbx

# utility procedure for colours below
proc r(r: uint8, g: uint8, b: uint8): ColorRGBX =
    return rgbx(r, g, b, 255)
#[ terminology used for colours:
   - colours are categorised, and each category have '--' section to signify attributes
   - most colours take name from -encycolorpedia.com- or other source
   - HTML colours are in STD list, but if they feel odd, they will get their h[NAME] variant
   - Unnamed colours will get their custom name, but prefixed: u[NAME]                       ]#

const
  #[ Standard colours ]#
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
  ORANGE* = r(255, 136,   0)
  PINK*   = r(255, 192, 203)
  #[ HTML variants ]#
  hBROWN* = r(165,  42,  42)

  #[ White-like shades ]#

  #[ Black-like shades ]#
  RAISIN_BLACK* = r( 36,  33,  36)
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
  VIOLET*        = r(113,   1, 147) # -- classic
  DARK_PURPLE*   = r( 48,  25,  52) # -- dark
  PURPLE_NAVY*   = r( 78,  81, 128) # -- blue-driven
  # [Brown-like shades ]#
  COMEX_CAOBA*   = r(136,  66,  29) # -- classic
  CHOCOLATE*     = r(123,  63,   0)
  uDARK_BROWN*   = r( 46,  25,  21) # -- dark
  PULLMAN_BROWN* = r(100,  65,  23)
  ACAJOU*        = r( 76,  47,  39)
  BAIKO*         = r(133, 124,  85) # -- gray-driven
  IWAI*          = r( 94,  85,  69)
  #[ Cyan-like shades ]#
  AQUA*       = r(  0, 255, 255) # -- bright
  AQUAMARINE* = r(127, 255, 212)
  TEAL*       = r(  0, 128, 128) # -- teal-like
  #[ Lime-like shades ]#
  LIME_PULP*   = r(209, 225, 137) # -- bleak
  ARCTIC_LIME* = r(208, 255,  20) # -- bright:neon
  LEMON_LIME*  = r( 92, 255, 103) # -- bright
  #[ Cream-like shades ]#
  COLORTREND_CREAM* = r(250, 225, 165) # -- orange-driven
  uYELLOW_CREAM*    = r(255, 247, 157) # -- yellow-driven
  uGRAYED_CREAM*    = r(212, 205, 189) # -- gray-driven
  #[ Orange-like shades ]#
  ORANGE_RED*       = r(255, 104,  31) # -- classic
  uDARK_ORANGE_RED* = r(220,  57,  21) # -- red-driven
  #[ Pink-like shades ]#
  CHINESE_PINK*  = r(222, 112, 161) # -- purple-like
  AMERICAN_PINK* = r(255, 152, 153) # -- pastel
  BARBIE_PINK*   = r(233,  65, 150)

proc toRGBX* (tup: (uint8, uint8, uint8, uint8)): ColorRGBX =
    result = rgbx(tup[0], tup[1], tup[2], tup[3])

proc toRGBX* (hex: string): ColorRGBX =
    result = parseHexAlpha(hex).asRgbx()