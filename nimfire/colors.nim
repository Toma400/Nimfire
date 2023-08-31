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
  RED*    = r(255,   0,   0)
  YELLOW* = r(255, 255,   0)
  PURPLE* = r(128,   0, 128)
  CYAN*   = r(  0, 255, 255)
  #[ Green-like shades ]#
  LIME*      = r(  0, 255,   0) # -- bright
  SCREAMIN*  = r( 48, 255,  96)
  MINT*      = r(168, 255, 168)
  MOSS*      = r(168, 216, 168) # -- bleak
  HIPPIE*    = r( 96, 144,  72)
  PASTEL*    = r(120, 216, 120)
  VERDUN*    = r( 72, 120,   0) # -- dark
  FERN*      = r( 72, 120,  48)
  TIMBER*    = r( 24,  48,  48)
  KAITOKE*   = r(  0,  72,  48)
  SPRING*    = r(  0, 240, 168) # -- cyan-driven : blue
  CARIBBEAN* = r(  0, 192, 168)
  PERSIAN*   = r(  0, 168, 144)
  OCEAN*     = r( 72, 168, 144)
  PINE*      = r(  0, 120, 120)
  SEA*       = r( 48, 168,  96) # -- cyan-driven : green
  JUNGLE*    = r( 48, 192, 120)
  CHATEAU*   = r( 72, 168,  96)
  TEA*       = r(216, 240, 192) # -- creamy-driven
  LIME_PULP* = r(209, 225, 137)
  MINERAL*   = r( 72,  96,  96) # -- gray-driven
  SHADOW*    = r(144, 192, 192)
  SUMMER*    = r(144, 192, 168)
  VIRIDIAN*  = r( 96, 144, 120)
  SWAMP*     = r(168, 192, 144)
  GLADE*     = r( 96, 144,  96)
  YELLOW*    = r(168, 255,  72) # -- yellow-driven
  GRANITE*   = r(144, 144, 120) # -- brown-driven
  CHETWODE*  = r(255, 153,   0) # -- white-driven
  #[ Red-like shades ]#
  MAROON*  = r(128,   0,   0)
  CLARET*  = r(100,  29,  47)
  #[ Pink-like shades ]#
  FUCHSIA* = r(255,   0, 255)
  #[ Cyan-like shades ]#
  AQUA*    = r(  0, 255, 255) # -- bright
  # [Brown-like shades ]#
  ACAJOU*  = r( 76,  47,  39) # -- dark

proc toRGBX* (tup: (uint8, uint8, uint8, uint8)): ColorRGBX =
    result = rgbx(tup[0], tup[1], tup[2], tup[3])

proc toRGBX* (hex: string): ColorRGBX =
    result = parseHexAlpha(hex).asRgbx()