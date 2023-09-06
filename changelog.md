# Changelog
- [0.1](#0.1.x)
  - [0.1.1](#0.1.1) 
  - [0.1.0](#0.1.0)

---
## 0.1.x

### 0.1.1
Additions:
  - added `toRect` conversion from Image object
  - added several new keys to be recognised
  - added several new colours
  - added utility proc to check screen size

Improvements:
  - `drawRect` does not require `var` type of Rect object, so can be iterated
    more easily
  - `setPixelRelative` now serves as relative `setPixel` alternative

Fixes:
  - fixed wrong Nimble dependencies that assumed NGLFW/gl*FB are in Nimble list 

### 0.1.0
Additions:
  - added basic Window handler
  - added colors
  - added drawing shapes
  - added drawing images
  - added image saving
  - added several utility procs
  - added handling of keyboard & mouse clicking
  - getting mouse position