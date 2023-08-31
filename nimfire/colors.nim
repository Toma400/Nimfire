from chroma import rgbx, ColorRGBX

const
  WHITE*  = rgbx(255, 255, 255, 255)
  BLACK*  = rgbx(  0,   0,   0, 255)
  PURPLE* = rgbx(128,   0, 128,   1)

proc toRGBX* (tup: (uint8, uint8, uint8, uint8)): ColorRGBX =
    result = rgbx(tup[0], tup[1], tup[2], tup[3])