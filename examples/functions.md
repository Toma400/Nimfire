# Modules
- [nimfire](#nimfire)
- [nimfire/input](#nimfireinput)
- [nimfire/image](#nimfireimage)
- [nimfire/draw](#nimfiredraw)
- [nimfire/utils](#nimfireutils)
- [nimfire/colors](#nimfirecolors)
- nimfire/types
<!-- - nimfire/ui -->
Experimental
- [nimfire/indev/collection](#nimfireindevcollection)
- [nimfire/indev/simpleui](#nimfireindevsimpleui)
- [nimfire/indev/decorui](#nimfireindevdecorui)
- [nimfire/indev/text](#nimfireindevtext)

---
# Nimfire
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
                  resizable : bool        = false,
                  bg_colour : ColorRGBX   = BLACK): Window
```
Arguments:

|   Name    |    Type    |    Treatment     | Description                                          |
|:---------:|:----------:|:----------------:|:-----------------------------------------------------|
|    res    | (int, int) |   **required**   | resolution of the window                             |
|   title   |   string   |   **required**   | title of the window                                  |
| resizable |    bool    | default: `false` | whether window can be resized or not                 |
| bg_colour | ColorRGBX  |    *optional*    | colour of the background (see also `nimfire/colors`) |

Also uses alias `ignite()` for fun Nimfire reference.

### tick
Returns whether Window is ticking (is open) or not.
```nim
proc tick* (w: Window): bool
```
Arguments:

| Name |  Type  |  Treatment   | Description                        |
|:----:|:------:|:------------:|:-----------------------------------|
|  w   | Window | **required** | Window object we check for ticking |

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

|  Name  |     Type     |    Treatment     | Description                              |
|:------:|:------------:|:----------------:|:-----------------------------------------|
|   w    | `var` Window |   **required**   | Window object that gets updated          |
| manual |     bool     | default: `false` | whether screen is not redrawn every tick |

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
proc getRes* (w: Window): (int, int)
```
Arguments:

| Name |  Type  |  Treatment   | Description                      |
|:----:|:------:|:------------:|:---------------------------------|
|  w   | Window | **required** | window resolution is checked for |

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
# Nimfire/input
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

---
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
proc getMousePos* (w: Window): (int, int)
```
Arguments:

| Name |  Type  |   Treatment   | Description                   |
|:----:|:------:|:-------------:|:------------------------------|
|  w   | Window | **required**  | Window object used by our app |


---
# Nimfire/image
Nimfire module allowing you to control images and manipulate them on app window.

Types:
  - [Image](#image) : object
    - pos
    - png
    - res
    - matrix
    - fatrix

Functions:
  - [newImage](#newimage)
  - [drawImage](#drawimage)
  - [move](#move-image)
  - [collide](#collide-image)
  - [collidePrecise](#collideprecise)
  - [saveImage](#saveimage)
  - epos
  - isWithin
  - createMatrix
  - [filterMatrix](#filtermatrix)

---
### Image
**Type**: object

Image type representing single image, either imported through [newImage](#newimage)
proc from file, or converted from other type such as [Rect](#toimage).

Can be [converted into Rect](#torect) type.

Fields:

|  Name  |                 Type                 | Usage details                                                                                                              |
|:------:|:------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------|
|  pos   |              (int, int)              | initial position of Image, if skipped it takes default value of (0, 0) and can be overwritten during [drawing](#drawimage) |
|  res   |              (int, int)              | size of Image, derived from the builder                                                                                    | 
|  png   |              pixie.Png               | Png object from Pixie library                                                                                              |
| matrix | OrderedTable\[(int, int), ColorRGBX] | OrderedTable containing all pixels of the Image, paired into coordinates-color value hash                                  |
| fatrix | OrderedTable\[(int, int), ColorRGBX] | OrderedTable containing filtered data of `matrix` field, cleared from all transparent pixels. It is used for drawing       |

---
### newImage  
Creates Image object that handles specific image in memory and allows you to
transform it.   
Currently, Nimfire only allows for PNG files to be loaded.
```nim
proc newImage* (path : string,
                pos  : (int, int) = (0, 0)): Image
```
Arguments:

| Name |    Type    |  Treatment   | Description                                      |
|:----:|:----------:|:------------:|:-------------------------------------------------|
| path |   string   | **required** | path to the image file                           |
| pos  | (int, int) |  *optional*  | position on screen in where Image will be loaded |

### drawImage
Draws Image object [initialised earlier](#newimage) into Window object.
```nim
proc drawImage* (w    : var Window, 
                 i    : Image, 
                 pos  : (int, int) = i.pos, 
                 cond : bool       = true)
```
Arguments:

| Name |     Type     |             Treatment              | Description                                                                                              |
|:----:|:------------:|:----------------------------------:|:---------------------------------------------------------------------------------------------------------|
|  w   | `var` Window |            **required**            | Window object being drawn into                                                                           |
|  i   |    Image     |            **required**            | Image object being drawn                                                                                 |
| pos  |  (int, int)  | default: <br> `pos` field of Image | coordinates where Image should be drawn. Can be avoided to use position declared at Image initialisation |
| cond |     bool     |          default: `true`           | boolean expression that allow you to condition Image drawing                                             |

Technically, it is worth remembering that drawing is done by iterating over `fatrix`
field of Image type. Therefore, any changes that affect `fatrix` data will affect
image drawn and reversely, lack of those will leave image intact.  
Proc [filterMatrix](#filtermatrix) can be used to recreate valid `fatrix` field.

### move `Image`
Utility function that let you easily move Image from its current position.
```nim
proc move* (i: var Image, pos: (int, int))

proc move* (i: var Image, x: int, y: int)
```
Arguments:

| Name |    Type     |  Treatment   | Description                                                                                                                               |
|:----:|:-----------:|:------------:|:------------------------------------------------------------------------------------------------------------------------------------------|
|  i   | `var` Image | **required** | Image object being moved                                                                                                                  |
| pos  | (int, int)  | **required** | Relative position Image should be moved with. Use negative and positive values for direction <br> ✮ Can be overloaded with two int values |
| x, y |     int     | **required** | Relative position Image should be moved with. Use negative and positive values for direction <br> ✮ Can be overloaded with int tuple.     |

Moving has inverted Y treatment, so if you want to move Image upwards, use `(n, -n)`
value.

### collide `Image`
Checks whether Image collides with either specific position or another Image.
```nim
proc collide* (i: Image, pos: (int, int)): bool

proc collide* (i: Image, x: int, y: int): bool

proc collide* (i: Image, i2: Image): bool
```
Arguments:

| Name |    Type    |  Treatment   | Description                                                                                                         |
|:----:|:----------:|:------------:|:--------------------------------------------------------------------------------------------------------------------|
|  i   |   Image    | **required** | Image object collision being checked                                                                                |
| pos  | (int, int) | **required** | position being checked for collision, as tuple of ints <br> ✮ Can be overloaded with two int values or Image object |
| x, y |    int     | **required** | position being checked, as two int values <br> ✮ Can be overloaded with int tuple or Image object                   |
|  i2  |   Image    | **required** | another Image object being checked for collisions <br> ✮ Can be overloaded with int tuple or two int values         | 

Performing `collide()` check is done using image's rectangular shape, which means that
it is faster, but does not check whether pixels are solid.  
For more resource-heavy check that counts only non-transparent pixels, use [collidePrecise](#collideprecise).

### collidePrecise
More performance-heavy alternative to [collide](#collide) that performs collision
check on `fatrix` field, resulting on collision being checked only on non-transparent
pixels.
```nim
proc collidePrecise* (i: Image, pos: (int, int)): bool

proc collidePrecise* (i: Image, x: int, y: int): bool 

proc collidePrecise* (i: Image, i2: Image): bool
```
Arguments:

| Name |    Type    |  Treatment   | Description                                                                                                         |
|:----:|:----------:|:------------:|:--------------------------------------------------------------------------------------------------------------------|
|  i   |   Image    | **required** | Image object collision being checked                                                                                |
| pos  | (int, int) | **required** | position being checked for collision, as tuple of ints <br> ✮ Can be overloaded with two int values or Image object |
| x, y |    int     | **required** | position being checked, as two int values <br> ✮ Can be overloaded with int tuple or Image object                   |
|  i2  |   Image    | **required** | another Image object being checked for collisions <br> ✮ Can be overloaded with int tuple or two int values         | 

### saveImage
Saves Image object as a PNG file to specific path.
```nim
proc saveImage* (i: Image, name: string)
```
Arguments:

| Name |  Type  |  Treatment   | Description                                                                     |
|:----:|:------:|:------------:|:--------------------------------------------------------------------------------|
|  i   | Image  | **required** | Image object being saved                                                        |
| name | string | **required** | name of the file (should contain also extension being `.png`) and optional path |

### filterMatrix
Filters `matrix` field of transparent blocks, letting drawing be performed only on
pixels that can be seen.  
Can be used to recreate valid `fatrix` field.
```nim
proc filterMatrix* (matrix: OrderedTable[(int, int), ColorRGBX]): OrderedTable[(int, int), ColorRGBX]
```
Arguments:

|  Name  |                Type                 |  Treatment   | Description                   |
|:------:|:-----------------------------------:|:------------:|:------------------------------|
| matrix | OrderedTable[(int, int), ColorRGBX] | **required** | Matrix table that is filtered |

---
# Nimfire/draw
Nimfire module that let you draw shapes on app window and manipulate them.

Types:
  - [Rect](#rect) : object
    - pos
    - size
    - colour
    - matrix

Functions:
  - [newRect](#newrect)
  - [drawRect](#drawrect)
  - [move](#move-rect)
  - [collide](#collide-rect)
  - [toImage](#toimage)
  - [toRect](#torect)
  - drawBackground
  - setColour
  - [setPixel](#setpixel)
  - [setPixelAbsolute](#setpixelabsolute)
  - [setPixelRelative](#setpixelrelative)
  - clearPixels
  - epos
  - isWithin
  - createMatrix

---
### Rect
**Type**: object

Rect type representing rectangular shape of given colour.

Can be [converted into Image](#toimage) type.

Fields:

|  Name  |                 Type                 | Usage details                                                                            |
|:------:|:------------------------------------:|:-----------------------------------------------------------------------------------------|
|  pos   |              (int, int)              | initial position of rectangle. Can be overwritten during drawing                         |
|  size  |              (int, int)              | size of rectangle, given explicitly as tuple of ints                                     | 
| colour |              ColorRGBX               | colour of rectangle (suggested to use [Colour enum](#nimfirecolors))                     |
| matrix | OrderedTable\[(int, int), ColorRGBX] | OrderedTable containing all pixels of the Rect, paired into coordinates-color value hash |

---
### newRect  
Creates Rect object out of given coordinates and size.
```nim
proc newRect* (pos: (int, int), size: (int, int), colour: ColorRGBX): Rect
```
Arguments:

|  Name  |    Type    |  Treatment   | Description                                                                           |
|:------:|:----------:|:------------:|:--------------------------------------------------------------------------------------|
|  pos   | (int, int) | **required** | initial position for the rectangle                                                    |
|  size  | (int, int) | **required** | size of rectangle                                                                     |
| colour | ColorRGBX  | **required** | colour rectangle will be filled with (suggested to use [Colour enum](#nimfirecolors)) |

### drawRect
Draws rectangle on Window object. Unlike [Image drawing](#drawimage) it doesn't require
initialised object, and you can draw shapes freely. However, take in mind that drawing
without Rect object doesn't give you as much control.
```nim
proc drawRect* (w      : var Window, 
                pos    : (int, int), 
                size   : (int, int), 
                colour : ColorRGBX, 
                cond   : bool = true)

proc drawRect* (w    : Window,
                r    : Rect,
                cond : bool = true)

proc drawRect* (w    : var Window,
                r    : var Rect,
                cond : bool = true,
                pos  : (int, int)   = r.pos)
```
Arguments (drawing freely):

|  Name  |     Type     |    Treatment    | Description                                                               |
|:------:|:------------:|:---------------:|:--------------------------------------------------------------------------|
|   w    | `var` Window |  **required**   | Window object being drawn into                                            |
|  pos   |  (int, int)  |  **required**   | sets position of rectangle                                                |
|  size  |  (int, int)  |  **required**   | sets size of rectangle                                                    |
| colour |  ColorRGBX   |  **required**   | sets colour of rectangle (suggested to use [Colour enum](#nimfirecolors)) |
|  cond  |     bool     | default: `true` | boolean expression that allow you to condition Rect drawing               |

Arguments (using Rect object):

| Name |  Type  |    Treatment    | Description                                                 |
|:----:|:------:|:---------------:|:------------------------------------------------------------|
|  w   | Window |  **required**   | Window object being drawn into                              |
|  r   |  Rect  |  **required**   | Rect object being drawn                                     |
| cond |  bool  | default: `true` | boolean expression that allow you to condition Rect drawing |

Arguments (using Rect object, with overriding of position):

| Name |     Type     |             Treatment             | Description                                                 |
|:----:|:------------:|:---------------------------------:|:------------------------------------------------------------|
|  w   | `var` Window |           **required**            | Window object being drawn into                              |
|  r   |  `var` Rect  |           **required**            | Rect object being drawn                                     |
| pos  |  (int, int)  | default: <br> `pos` field of Rect | overrides position given during initialisation              |
| cond |     bool     |          default: `true`          | boolean expression that allow you to condition Rect drawing |


### move `Rect`
Utility function that let you easily move Rect from its current position.
```nim
proc move* (r: var Rect, pos: (int, int))

proc move* (r: var Rect, x: int, y: int)
```
Arguments:

| Name |    Type    |  Treatment   | Description                                                                                                                              |
|:----:|:----------:|:------------:|:-----------------------------------------------------------------------------------------------------------------------------------------|
|  r   | `var` Rect | **required** | Rect object being moved                                                                                                                  |
| pos  | (int, int) | **required** | Relative position Rect should be moved with. Use negative and positive values for direction <br> ✮ Can be overloaded with two int values |
| x, y |    int     | **required** | Relative position Rect should be moved with. Use negative and positive values for direction <br> ✮ Can be overloaded with int tuple.     |

Moving has inverted Y treatment, so if you want to move Rect upwards, use `(n, -n)`
value.

### collide `Rect`
Checks whether Rect collides with either specific position or another Rect.
```nim
proc collide* (r: Rect, pos: (int, int)): bool

proc collide* (r: Rect, x: int, y: int): bool

proc collide* (r: Rect, r2: Rect): bool
```
Arguments:

| Name |    Type    |  Treatment   | Description                                                                                                        |
|:----:|:----------:|:------------:|:-------------------------------------------------------------------------------------------------------------------|
|  r   |    Rect    | **required** | Rect object collision being checked                                                                                |
| pos  | (int, int) | **required** | position being checked for collision, as tuple of ints <br> ✮ Can be overloaded with two int values or Rect object |
| x, y |    int     | **required** | position being checked, as two int values <br> ✮ Can be overloaded with int tuple or Rect object                   |
|  r2  |    Rect    | **required** | another Rect object being checked for collisions <br> ✮ Can be overloaded with int tuple or two int values         | 

### toImage
Converts Rect into [Image](#image) type.
```nim
proc toImage* (r: Rect): Image
```
Arguments:

| Name | Type |  Treatment   | Description                 |
|:----:|:----:|:------------:|:----------------------------|
|  r   | Rect | **required** | Rect object being converted |

### toRect
Converts [Image](#image) type into Rect.
```nim
proc toRect* (i: Image): Rect
```
Arguments:

| Name | Type  |  Treatment   | Description                  |
|:----:|:-----:|:------------:|:-----------------------------|
|  i   | Image | **required** | Image object being converted |

### setPixel
Sets pixel on specific coordinate of Rect object.  
Uses relative positioning (so `0,0` means upper top of Rect, not upper top of Window).  
Performs check whether position is between 0 and Rect size.  
For absolute variant, see [setPixelAbsolute](#setpixelabsolute) proc.

```nim
proc setPixel* (r: var Rect, pos: (int, int), colour: ColorRGBX)

proc setPixel* (r: var Rect, x: int, y: int, colour: ColorRGBX)
```
Arguments:

|  Name  |    Type    |  Treatment   | Description                                                                                                                   |
|:------:|:----------:|:------------:|:------------------------------------------------------------------------------------------------------------------------------|
|   r    | `var` Rect | **required** | Rect object that is being used                                                                                                |
|  pos   | (int, int) | **required** | Relative position that is being drawn into. Skips drawing if outside of Rect <br> ✮ Can be overloaded with two int values     |
|  x, y  |    int     | **required** | Relative position that is being drawn into. Skips drawing if outside of Rect  <br> ✮ Can be overloaded with tuple of two ints |
| colour | ColorRGBX  | **required** | Colour being drawn in position (suggested to use [Colour enum](#nimfirecolors))                                               |

### setPixelAbsolute
Sets pixel on specific coordinate of Rect object. It is absolute and performs
check on whether given coordinates belong to Rect.  

```nim
proc setPixelAbsolute* (r: var Rect, pos: (int, int), colour: ColorRGBX)

proc setPixelAbsolute* (r: var Rect, x: int, y: int, colour: ColorRGBX)
```
Arguments:

|  Name  |    Type    |  Treatment   | Description                                                                                                                   |
|:------:|:----------:|:------------:|:------------------------------------------------------------------------------------------------------------------------------|
|   r    | `var` Rect | **required** | Rect object that is being used                                                                                                |
|  pos   | (int, int) | **required** | Absolute position that is being drawn into. Skips drawing if outside of Rect <br> ✮ Can be overloaded with two int values     |
|  x, y  |    int     | **required** | Absolute position that is being drawn into. Skips drawing if outside of Rect  <br> ✮ Can be overloaded with tuple of two ints |
| colour | ColorRGBX  | **required** | Colour being drawn in position (suggested to use [Colour enum](#nimfirecolors))                                               |

---
# Nimfire/utils
Nimfire module that holds some useful utility procs that are not related directly
to any core feature.

Functions:
  - [getScreenRes](#getscreenres)
  - getPxPerc
  - p
  - pax
  - pay

---
### getScreenRes
Returns screen resolution as a tuple. Currently only support Windows OS and raises
error if called from different one.
```nim
proc getScreenRes* (): (int, int)
```

---
# Nimfire/colors
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

proc toRGBX* (r: uint8, g: uint8, b: uint8, a: uint8): ColorRGBX

proc toRGBX* (hex: string): ColorRGBX
```
Arguments:

|    Name    |             Type             |  Treatment   | Description                                                                                                            |
|:----------:|:----------------------------:|:------------:|:-----------------------------------------------------------------------------------------------------------------------|
|    tup     | (uint8, uint8, uint8, uint8) | **required** | Turns tuple of four uint8 values into ColorRGBX object <br> ✮ Can be overloaded with string or four uint8 values       |
| r, g, b, a |            uint8             | **required** | Turns four uint8 values into ColorRGBX object <br> ✮ Can be overloaded with string or uint8 tuple                      |
|    hex     |            string            | **required** | Turns string representing hexcode into ColorRGBX object <br> ✮ Can be overloaded with uint8 tuple or four uint8 values |

---
# Nimfire/indev/collection
Experimental Nimfire module that allows you to collect Image objects.  
This allows for easier mass-management or categorising of them, for various purposes,
for example "non-walkable sprites" category or one with shared behaviour.

Inspired heavily by mesh categorising of Morrowind and thinking how to translate this
into 2D environment.

Types:
  - [Collection](#collection) : object
    - elems
    - fatrix

Functions:
  - [newCollection](#newcollection)
  - [drawCollection](#drawcollection)
  - [collide](#collide-collection)
  - [add](#add)
  - [remove](#remove)

---
### Collection
**Type**: object

Object that collects multiple Image objects.

Fields:

|  Name  |        Type         | Usage details                                          |
|:------:|:-------------------:|:-------------------------------------------------------|
| elems  |     seq[Image]      | list of all images collected                           |
| fatrix | HashSet[(int, int)] | set of all pixel positions used by collection elements |

---
### newCollection
Basic Collection constructor, allowing you to store Image objects in it.  
Note that passing no Image objects results in empty Collection.
```nim
proc newCollection* (elems : varargs[Image]) : Collection
```
Arguments:

|     Name     |      Type      |                          Treatment                           | Description                                                |
|:------------:|:--------------:|:------------------------------------------------------------:|:-----------------------------------------------------------|
|    elems     | varargs[Image] | default: <br> no arguments passed result in empty Collection | Image objects that you initially want to add to Collection |

### drawCollection
Draws entire Collection on Window object.
```nim
proc drawCollection* (w: var Window, col: Collection)
```
Arguments:

| Name |     Type     |  Treatment   | Description                                        |
|:----:|:------------:|:------------:|:---------------------------------------------------|
|  w   | `var` Window | **required** | Window object being drawn on                       |
| col  |  Collection  | **required** | Collection which its elements are being drawn from |

### collide `Collection`
Collision check for Collection elements, returning whether specific positions is
within their range.
```nim
proc collide* (col: Collection, pos: (int, int)): bool
```
Arguments:

| Name |    Type    |  Treatment   | Description                             |
|:----:|:----------:|:------------:|:----------------------------------------|
| col  | Collection | **required** | Collection being checked for collisions |
| pos  | (int, int) | **required** | Position being checked against          |

It's important to note that algorithm for this function is not as performant as
regular `collide` as it works in similar vein as [collidePrecise](#collideprecise).  
It is a bit more optimised for large Collections, but still suffers from similar
issues of iterating over `fatrix` field.

### add 
Expands Collection of new Image.
```nim
proc add* (col: var Collection, i: Image)
```
Arguments:

| Name |       Type       |  Treatment   | Description               |
|:----:|:----------------:|:------------:|:--------------------------|
| col  | `var` Collection | **required** | Collection being added to |
|  i   |      Image       | **required** | Image being added         |

### remove
Removes Image from collection on specific position.
```nim
proc remove* (col: var Collection, index: int)
```
Arguments:

| Name  |       Type       |  Treatment   | Description                   |
|:-----:|:----------------:|:------------:|:------------------------------|
|  col  | `var` Collection | **required** | Collection being removed from |
| index |       int        | **required** | Image index being removed     |

Note that removal of Image requires Collection to rebuild `fatrix` which can
have smaller or bigger impact on performance during this process, depending
on Collection size.  
Thus, it is recommended to not use `remove` too often.

---
# Nimfire/indev/simpleui
Experimental Nimfire module that allows you to draw UI elements.  
Unlike [decorui](#nimfireindevdecorui), it operates only on primitive elements,
such as [Rect](#rect) objects.
Its main use case is being practical, not particularly aesthetical or customisable.

Types:
  - [ProgressBar](#progressbar) : object
    - pos
    - size
    - range
    - progress
    - bg_col
    - progress_col
    - bg_rect

Functions:
  - [newProgressBar](#newprogressbar)
  - [drawProgressBar](#drawprogressbar)

---
### ProgressBar
**Type**: object

GUI object that allows showcasing various kinds of progress.

Fields:

|     Name     |    Type    | Usage details                                                                                                                                                     |
|:------------:|:----------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     pos      | (int, int) | initial position of bar. Can be overwritten during drawing                                                                                                        |
|     size     | (int, int) | size of bar, given explicitly as tuple of ints                                                                                                                    |
|    range     | (int, int) | range of numbers passed into `progress` field (by default, 0..100 is used)                                                                                        |
|   progress   |    int     | number signifying progress of the bar, in % values. Does not protect against overflows, so manual check for value passed being between 0 and 100 needs to be made |
|    bg_col    | ColorRGBX  | colour of background rectangle (hidden below progress one). It is suggested to use [Colour enum](#nimfirecolors)                                                  |
| progress_col | ColorRGBX  | colour of progress rectangle (dynamic). It is suggested to use [Colour enum](#nimfirecolors)                                                                      |
|   bg_rect    |    Rect    | Rect object of background rectangle                                                                                                                               |

Progress value being only between 0 and 100, as well as having no guardrails may be
something to change in upcoming releases.

---
### newProgressBar
Basic ProgressBar constructor, allowing you to initialise it.
```nim
proc newProgressBar* (pos          : (int, int),
                      size         : (int, int),
                      progress     : int        = 100,
                      range        : (int, int) = (0, 100),
                      bg_col       : ColorRGBX  = WHITE,
                      progress_col : ColorRGBX  = PINE_GREEN): ProgressBar
```
Arguments:

|     Name     |    Type    |        Treatment         | Description                                                                  |
|:------------:|:----------:|:------------------------:|:-----------------------------------------------------------------------------|
|     pos      | (int, int) |       **required**       | initial position for the bar                                                 |
|     size     | (int, int) |       **required**       | size of the bar                                                              |
|   progress   |    int     |    default: <br> 100     | initial progress amount (can be overwritten later)                           |
|    range     | (int, int) |  default: <br> (0, 100)  | range of numbers used between start and end of progress bar                  |
|    bg_col    | ColorRGBX  |   default: <br> WHITE    | background rectangle colour (suggested to use [Colour enum](#nimfirecolors)) |
| progress_col | ColorRGBX  | default: <br> PINE_GREEN | progress rectangle colour (suggested to use [Colour enum](#nimfirecolors))   |

### drawProgressBar
Procedure allowing you to draw and update ProgressBar object.
```nim
proc drawProgressBar* (w        : var Window,
                       pb       : var ProgressBar,
                       pos      : (int, int) = pb.pos,
                       progress : int        = pb.progress,
                       cond     : bool       = true)
```
Arguments:

|   Name   |       Type        |                   Treatment                   | Description                                                                                |
|:--------:|:-----------------:|:---------------------------------------------:|:-------------------------------------------------------------------------------------------|
|    w     |   `var` Window    |                 **required**                  | window we draw bar on                                                                      |
|    pb    | `var` ProgressBar |                 **required**                  | bar object                                                                                 |
|   pos    |    (int, int)     |   default: <br> `pos` field of ProgressBar    | overrides bar position if used                                                             |
| progress |        int        | default: <br> `progress` field of ProgressBar | overrides bar progress if used. Passing value outside 0..100 range will overflow the image |
|   cond   |       bool        |             default: <br> `true`              | boolean expression that allow you to condition ProgressBar drawing                         |

---
# Nimfire/indev/decorui
Experimental Nimfire module that allows you to draw UI elements.  
Unlike [simpleui](#nimfireindevsimpleui), it operates on more aesthetically pleasing
elements, allowing also for broader customisation.

Types:
  - [DecorButton](#decorbutton) : object
    - un_image
    - ac_image
    - state
    - pos
  
Functions:
  - [newDecorButton](#newdecorbutton)
  - drawDecorButton
  - [setListener](#setlistener)
  - [isClicked](#isclicked)
  - [isClickedListener](#isclickedlistener)

---
### DecorButton
**Type**: object

GUI object which allows creating Image-based buttons.

Fields:

|   Name   |    Type    | Usage details                                          |
|:--------:|:----------:|:-------------------------------------------------------|
| un_image |   Image    | Image object that is drawn when button is not pressed  |
| ac_image |   Image    | Image object that is drawn when button is pressed      |
| hv_image |   Image    | Image object that is drawn when button is hovered upon |
|  state   |    bool    | stores information whether button is pressed or not    |
|   pos    | (int, int) | position of DecorButton                                |

---
### newDecorButton
Creates new DecorButton object.
```nim
proc newDecorButton* (pos: (int, int), uim: Image,
                                       aim: Image = uim,
                                       him: Image = uim): DecorButton
```
Arguments:

| Name |    Type    |         Treatment         | Description                                                                |
|:----:|:----------:|:-------------------------:|:---------------------------------------------------------------------------|
| pos  | (int, int) |       **required**        | initial position of the button                                             |
| uim  |   Image    |       **required**        | Image object representing default state (false) when button is not pressed |
| aim  |   Image    | default: <br> *uim* value | Image object representing pressed state (true)                             |
| him  |   Image    | default: <br> *uim* value | Image object representing hovered state                                    |

### setListener
Procedure that takes care of rendering updates of DecorButton object.  
In most cases, it should be used within game loop. 
```nim
proc setListener* (db: var DecorButton, w: Window, button: MouseButton = LEFT): DecorButton
```
Arguments:

|  Name  |       Type        |     Treatment      | Description                                             |
|:------:|:-----------------:|:------------------:|:--------------------------------------------------------|
|   db   | `var` DecorButton |    **required**    | button listening to events                              |
|   w    |      Window       |    **required**    | window to check events for                              |
| button |    MouseButton    | default: <br> LEFT | mouse action being listened to (by default: left-click) |

Since `setListener` returns value, you can use it to set listening immediately during
initialisation:
```nim
while window.tick():
  var button = newDecorButton((0, 0), image1, image2).setListener(window)
```
But since this requires initialisation within the loop, it is not really practical and
should be used only when absolutely necessary.  
However, using it in normal circumstances requires using `discard`:
```nim
while window.tick():
  discard button.setListener(window)
```

### isClicked
Proc that checks whether specific DecorButton is being clicked on.
```nim
proc isClicked* (w: Window, db: DecorButton, button: MouseButton = LEFT): bool
```
Arguments:

|  Name  |    Type     |     Treatment      | Description                                            |
|:------:|:-----------:|:------------------:|:-------------------------------------------------------|
|   w    |   Window    |    **required**    | window being checked on                                |
|   db   | DecorButton |    **required**    | button being checked on                                |
| button | MouseButton | default: <br> LEFT | mouse action being checked on (by default: left-click) |

Since `isClicked` performs the same check as `setListener`, you can use [isClickedListener](#isclickedlistener)
to optimise this action, if you use each of those once.  
In case you put multiple `isClicked` checks, it is better to keep `setListener` separate.

### isClickedListener
Proc optimising `isClicked` and `setListener` use by performing both tasks in shorter
manner. Should be used only if `isClicked` is performed once, else it becomes more
expensive than doing those checks in separation.
```nim
proc isClickedListener* (w: Window, db: var DecorButton, button: MouseButton = LEFT): bool
```
Arguments:

|  Name  |       Type        |     Treatment      | Description                                            |
|:------:|:-----------------:|:------------------:|:-------------------------------------------------------|
|   w    |      Window       |    **required**    | window being checked on                                |
|   db   | `var` DecorButton |    **required**    | button being checked on                                |
| button |    MouseButton    | default: <br> LEFT | mouse action being checked on (by default: left-click) |

---
# Nimfire/indev/text
Experimental Nimfire module that allows you to render text.  
In its current state, it may be overhauled heavily to let users have more control
over their input.

Types:
  - Text : object
    - bg_rect
    - text
    - font
    - size
    - pixmg
  - Fonts : enum

Functions:
  - newText
  - drawText