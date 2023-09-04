# Files
- [nimfire](#nimfire)
- [nimfire/input](#nimfireinput)
- [nimfire/image](#nimfireimage)
- [nimfire/draw](#nimfiredraw)
- [nimfire/utils](#nimfireutils)
- [nimfire/colors](#nimfirecolors)
- nimfire/types
<!-- - nimfire/ui -->

---
## Nimfire
Nimfire main module. Used for only basic handling of the application, such as
creating Window object and doing manipulation on its basic properties.

Functions:
  - [initWindow](#initwindow)
  - [tick](#tick)
  - [update](#update)
  - [finish](#finish)
  - [clear](#clear)
  - [fillPos](#fillpos)
  - [fillBackground](#fillbackground)
  - [getRes](#getres)
  - [isWithin](#iswithin)

Aliases:
  - [ignite](#initwindow)
  - [isBurning](#tick)
  - [addWood](#update)
  - [extinguish](#finish)

---
### initWindow  
Creates initial Window object that you use in your application.
```nim
proc initWindow* (res       : (int, int), 
                  title     : string, 
                  icon      : string      = "",
                  resizable : bool        = false,
                  bg_colour : ColorRGBX   = BLACK): Window
```
Arguments:

|   Name    |    Type    |    Treatment     | Description                                          |
|:---------:|:----------:|:----------------:|:-----------------------------------------------------|
|    res    | (int, int) |   **required**   | resolution of the window                             |
|   title   |   string   |   **required**   | title of the window                                  |
|   icon    |   string   |    *optional*    | path to window icon image                            |
| resizable |    bool    | default: `false` | whether window can be resized or not                 |
| bg_colour | ColorRGBX  |    *optional*    | colour of the background (see also `nimfire/colors`) |

Also uses alias `ignite()` for fun Nimfire reference.

### tick
Returns whether Window is ticking (is open) or not.
```nim
proc tick* (w: var Window): bool
```
Arguments:

| Name |     Type     |  Treatment   | Description                        |
|:----:|:------------:|:------------:|:-----------------------------------|
|  w   | `var` Window | **required** | Window object we check for ticking |

This is also considered as main loop handle, as it is created with use of `tick()`:
```nim
while window.tick():
  # main loop body
```
There's also alias `isBurning()` for fun Nimfire reference.

### update
Updates the window with gl*FB `update()` proc and clears the screen, if manual mode
is not used. Required to be within main loop.
```nim
proc update* (w: var Window, manual: bool = false)
```
Arguments:

|  Name  |     Type     |    Treatment     | Description                          |
|:------:|:------------:|:----------------:|:-------------------------------------|
|   w    | `var` Window |   **required**   | Window object that gets updated      |
| manual |     bool     | default: `false` | whether screen is redrawn every tick |

It is recommended to put this proc at the end of main loop, especially if `manual`
field is set to default.  
We can change `manual` mode to true, but be aware that this means you need to handle
every redraw of image or background. This, however, let you take care of Nimfire
performance a bit easier, since currently default auto-redrawing is slightly
expensive for memory.

Update also has Nimfire-referencing alias `addWood()`.

### finish
Ends the program by terminating the Window object.
```nim
proc finish* (w: var Window)
```
Arguments:

|  Name  |     Type     |    Treatment     | Description                        |
|:------:|:------------:|:----------------:|:-----------------------------------|
|   w    | `var` Window |   **required**   | Window object that gets terminated |

Also has `extinguish()` alias for fun Nimfire reference.

### clear
Clears the screen with default background colour. This proc is run automatically
during `update()` if manual mode is not turned on.
```nim
proc clear* (w: var Window)
```
Arguments:

| Name |     Type     |  Treatment   | Description                      |
|:----:|:------------:|:------------:|:---------------------------------|
|  w   | `var` Window | **required** | Window object that gets cleared  |

It is similar to [fillBackground()](#fillbackground) with the difference being
that `clear()` does not take any Colour argument, using the one set for Window
instead.

### fillPos
Draws pixel with colour on specific coordinates.  
Recommended to use only if you do not have possibility to draw in more
abstract way (i.e. by changing objects that get drawn as well).
```nim
proc fillPos* (w: var Window, pos: (int, int), colour: ColorRGBX)
```
Arguments:

|  Name  |     Type     |  Treatment   | Description                                         |
|:------:|:------------:|:------------:|:----------------------------------------------------|
|   w    | `var` Window | **required** | Window object that will pixel be drawn into         |
|  pos   |  (int, int)  | **required** | Coordinates of pixel to be drawn into               |
| colour |  ColorRGBX   | **required** | Colour value to be used (see also `nimfire/colors`) |

### fillBackground
Fills whole Window object with specific colour.
```nim
proc fillBackground* (w: var Window, colour: ColorRGBX = w.bg_colour)
```
Arguments:

|  Name  |     Type     |                 Treatment                 | Description                                         |
|:------:|:------------:|:-----------------------------------------:|:----------------------------------------------------|
|   w    | `var` Window |               **required**                | Window object that gets cleared                     |
| colour |  ColorRGBX   | default: <br> `bg_colour` field of Window | Colour value to be used (see also `nimfire/colors`) | 

### getRes
Returns tuple of current Window size. Should be used instead of `res` field, as
field itself doesn't get updated if Window is resized (it contains initial resolution).
```nim
proc getRes* (w: var Window): (int, int)
```
Arguments:

| Name |     Type     |  Treatment   | Description                        |
|:----:|:------------:|:------------:|:-----------------------------------|
|  w   | `var` Window | **required** | window resolution is checked for   |

### isWithin
Returns whether specific coordinates are within Window boundaries.
```nim
proc isWithin* (w   : var Window,
                pos : (int, int)): bool
```
Arguments:

| Name |     Type     |  Treatment   | Description                            |
|:----:|:------------:|:------------:|:---------------------------------------|
|  w   | `var` Window | **required** | window coordinates are checked against |
| pos  |  (int, int)  | **required** | coordinates as a tuple of ints         |

---
## Nimfire/input
Nimfire module handling user input on standard PC devices, such as keyboard and mouse.

Types:
  - [Key](#key)                 : enum
  - [MouseButton](#mousebutton) : enum

Constants:
  - [keys](#key)          : OrderedTable\[str, Key]
  - [mouse](#mousebutton) : OrderedTable\[str, MouseButton]

Functions:
  - [getKeyPressed](#getkeypressed)
  - [getMousePressed](#getmousepressed)
  - [getMousePos](#getmousepos)
  - anyKeysPressed
  - allKeysPressed

---
### Key
**Type**: enum

It's enum of keyboard keys that can be used for functions in this module.  
Can be referenced by string in `keys` constant.

### MouseButton
**Type**: enum

It's enum of mouse buttons that can be used for functions in this module.  
Can be referenced by string in `mouse` constant.

### getKeyPressed
Returns whether specific key is pressed, using either `Key` enum or string equivalent.  
String IDs can be found in `keys` const in [source file](/nimfire/input.nim).
```nim
proc getKeyPressed* (w: Window, k: Key): bool
    
proc getKeyPressed* (w: Window, k: string): bool
```
Arguments:

| Name |  Type  |  Treatment   | Description                                                                                |
|:----:|:------:|:------------:|:-------------------------------------------------------------------------------------------|
|  w   | Window | **required** | Window object used by our app                                                              |
|  k   |  Key   | **required** | Key enum that we check being used <br> ✮ Can be overloaded with `string` type              |
|      | string | **required** | String ID that equals to Key enum in `keys` Table <br> ✮ Can be overloaded with `Key` enum |

### getMousePressed
Returns whether specific mouse button is pressed, using either `MouseButton` enum
or string equivalent.  
String IDs can be found in `mouse` const in [source file](/nimfire/input.nim).
```nim
proc getMousePressed* (w: Window, button: MouseButton = LEFT): bool

proc getMousePressed* (w: Window, button: string): bool
```
Arguments:

|  Name  |    Type     |   Treatment   | Description                                                                                                 |
|:------:|:-----------:|:-------------:|:------------------------------------------------------------------------------------------------------------|
|   w    |   Window    | **required**  | Window object used by our app                                                                               |
| button | MouseButton | default: LEFT | MouseButton enum that we check being used <br> ✮ Can be overloaded with `string` type                       |
|        |   string    | **required**  | String ID that equals to MouseButton enum in `mouse` Table <br> ✮ Can be overloaded with `MouseButton` enum |

### getMousePos
Returns position of the cursor as a coordinates tuple.
```nim
proc getMousePos* (w: var Window): (int, int)
```
Arguments:

| Name |  Type  |   Treatment   | Description                   |
|:----:|:------:|:-------------:|:------------------------------|
|  w   | Window | **required**  | Window object used by our app |

### anyKeysPressed

### allKeysPressed

---
## Nimfire/image
Nimfire module allowing you to control images and manipulate them on app window.

Types:
  - Image : object
    - pos
    - png
    - res
    - matrix
    - fatrix

Functions:
  - newImage
  - drawImage
  - move
  - collide
  - collidePrecise
  - saveImage
  - epos
  - isWithin
  - createMatrix
  - filterMatrix

---
## Nimfire/draw
Nimfire module that let you draw shapes on app window and manipulate them.

Types:
  - Rect : object
    - pos
    - size
    - colour
    - matrix

Functions:
  - newRect
  - drawRect
  - move
  - collide
  - toImage
  - drawBackground
  - setColour
  - setPixel
  - clearPixels
  - epos
  - isWithin
  - createMatrix

---
## Nimfire/utils
Nimfire module that holds some useful utility procs that are not related directly
to any core feature.

Functions:
  - getPxPerc
  - p
  - pax
  - pay

---
## Nimfire/colors
Nimfire module allowing you to use ColoRGBX without explicitly calling `chroma` or
`pixie` dependencies this format is used in, as well as convert RGB/hexcode values.  

It is quite useful to take a look at [its constant values](/nimfire/colors.nim), as
this file has pretty handy documentation on what each colour name means without
even looking at specific RGB values or testing colour in practice.

Constants:
  - [Various, documented in module file](/nimfire/colors.nim)

Functions:
  - [toRGBX](#torgbx)

---
### toRGBX
Utility procedure that converts various data to RGBX. In numeral values, indexes
represent R, G, B and transparency value, respectively.
```nim
proc toRGBX* (tup: (uint8, uint8, uint8, uint8)): ColorRGBX

proc toRGBX* (args: varargs[uint8]): ColorRGBX

proc toRGBX* (hex: string): ColorRGBX
```
Arguments:

| Name |             Type             |  Treatment   | Description                                                                                                                                  |
|:----:|:----------------------------:|:------------:|:---------------------------------------------------------------------------------------------------------------------------------------------|
| tup  | (uint8, uint8, uint8, uint8) | **required** | Turns tuple of four uint8 values into ColorRGBX object <br> ✮ Can be overloaded with string or uint8 varargs                                 |
| args |        varargs[uint8]        | **required** | Turns four arguments into ColorRGBX object, raises IndexError if given different number  <br> ✮ Can be overloaded with string or uint8 tuple |
| hex  |            string            | **required** | Turns string representing hexcode into ColorRGBX object <br> ✮ Can be overloaded with uint8 tuple or uint8 varargs                           |

