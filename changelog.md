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
  - Remove deprecated `decorui` procs
  - 0.1.5 most probably:
    - adding `simpleui` Button (convertable to DecorButton)
    - Holder for UI elements, Rects and Images?
    - Px as separate type, not `utils` thing?
  - 0.1.5 most rationally:
    - newText from rect = fits the rect
    - newText from data = goes purely by data
-->
<!--
  - Added `icon` argument to `initWindow` allowing for customising of window's icon
  - Text
    - Adding coloured text with borders?
    - Adding experimental "multiple colours" (experimentators)
    - Adding experimental "multiple Paints" (Pixie knowers)
-->

### 0.1.4 (indev)
Additions:
  - `TRANSPARENT` "colour" is now reachable from `nimfire/draw`
  - Added new features for experimental `text` features:
    - You can now change your text after initialising the object
    - Text can now have colour set
  - Additional support for transparency and colour hashes in `nimfire/colors`

Changes:
  - Rewritten `indev/decorui` module, so now DecorButton element is much more intuitive
    - `setListener` and `isClickedListener` are now deprecated
    - `drawDecorButton` holds responsibility for updating the object with user's actions
  - Removed option to have default font with `newText`, to make module more readable,
    solve [#6](https://github.com/Toma400/Nimfire/issues/6) and avoid possible license
    issues - now all fonts need to be explicit
    - Also removed font files from repository
  - Small changes to `newText`, removing redundant overloads
  - Text now has always transparent background
    - You can set non-transparent background through `setBackground` function, but
      it must be called explicitly
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