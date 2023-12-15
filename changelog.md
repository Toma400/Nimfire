# Changelog
- [0.1](#0.1.x)
  - 0.1.4 `indev`
  - [0.1.3](#0.1.3)
  - [0.1.2](#0.1.2) 
  - [0.1.1](#0.1.1) 
  - [0.1.0](#0.1.0)

---
## 0.1.x
<!--  
Soonest todo:
  - Making `text` reliable on Rect size and more customised
  - Allowing for `icon` on Window (?)
  - 0.1.4 most probably:
    - adding `simpleui` Button (convertable to DecorButton)
    - Holder for UI elements, Rects and Images?
    - Px as separate type, not `utils` thing?
-->

### 0.1.4 (indev)
<!--
Additions:
  - Added `icon` argument to `initWindow` allowing for customising of window's icon
-->

Changes:
  - Removed `setPixelRelative` function being deprecated
    (use `setPixel` for its behaviour)

### 0.1.3
Additions:
  - `Collection` type that allows for mass management of Images
  - New `range` field used by ProgressBar to customise its values used

### 0.1.2
Additions:
  - Added experimental `nimfire/indev` section to test new unstable features
    - each module in there will have its stable substitute in main directory
      (`indev` variant will be deprecated by that time)
    - `simpleui` module let you create simple UI
      - currently it handles only `ProgressBar` element
        - improvements towards range will be introduced soon
    - `decorui` module let you create more advanced UI
      - currently it handles only `DecorButton` element
    - `text` module let you render text
      - rendering can be bugged and not work as expected

Changes:
  - `setPixel` behaviour has been changed to mimic `setPixelRelative` as default

Improvements:
  - removed redundant `icon` argument in Window initialisation
    - argument was set for future use, but adding icon was pushed forward in
      development plans

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