![](banner.png)
**Nimfire** (Nim Campfire) is small Nim GUI/game library inspired by PyGame and Nigui,
trying to be what I haven't found yet in Nim's gamedev ecosystem.  
While it is mostly my learning project, I'd love to see it becoming something bigger
in the future - I will try to update is regularly, so it should not be abandoned
anytime soon.

Nimfire aim is to:
- **empower control**
  - you are given as much manual control as possible, including contents of main loop
    (inspired by PyGame)
- **minimise abstractions**
  - you are not forced into any OOP system and relations, there's no object that
    you need inherit from or use to control your custom elements
- **have no dependencies**
  - one of huge issues with Nim gamelibs is their requirement to install and/or
    compile many C libraries and other dependencies - Nimfire uses only static
    Nim libraries which makes it work out of the box
- **be simple and user-friendly**
  - no unnecessary verbosity of code, we are coding Nim after all
  - well documented code, examples and possibility to learn from short examples
  - being batteries-included in terms of having GUI elements, so you don't need to
    write your own (it's totally possible though!)

### Installation
To install the library, simply run such command in terminal:
```
nimble install https://github.com/Toma400/Nimfire
```

### Usage
Initialising basic window is done using `initWindow` procedure. After that, you will
be able to control program loop and window closing:
```nim
import nimfire

var w = initWindow((800, 600), "Nimfire")

while w.tick():
  w.update()

w.finish()
```

You can also draw on canvas easily:
```nim
import nimfire/colors
import nimfire/draw
import nimfire

var w = initWindow((800, 600), "Nimfire")

while w.tick():
  w.drawRect((0, 0), (250, 250), PURPLE)
  w.update()

w.finish()
```
You can look at `examples/drawing` and `examples/rect_management` for more detailed
documentation on how you can use drawing with the library.

Aside of drawing shapes, Nimfire allows you also to use PNG images, further explained
in `examples/images` file:
```nim
import nimfire/image
import nimfire

var w = initWindow((800, 600), "Nimfire")
var i = newImage("nimfire.png")

while w.tick():
  w.drawImage(i, (10, 10))
  w.update()
  
w.finish()
```
And you can also handle user input:
```nim
import nimfire/input
import nimfire

var w = initWindow((800, 600), "Nimfire")

while w.tick():
  if w.getKeyPressed(KEY.SPACE):
    echo "Space just got used!"
  w.update()
  
  if w.getMousePressed(LEFT):
    echo "Mouse coordinates are: " & w.getMousePos()
  
w.finish()
```
For more code examples, visit `examples` folder. You can also look at `examples/apps`
for tutorial apps done step by step to showcase more abstract use of Nimfire.  
Additionally, module functions are slowly documented in [this](examples/functions.md)
Markdown file.

---
### Features
Currently, this is Nimfire's scope:
- [x] Creating app and controlling window
  - [x] Setting basic data (res, title) 
  - [x] Drawing shapes
    - [x] Exporting shapes into graphical files
- [x] Input control `mostly`
  - [x] Keyboard control
    - [x] Getting keyboard key being pressed
  - [x] Mouse control
    - [x] Recognising mouse input
    - [x] Getting mouse position on screen
  - [ ] Saving user input as data (listening to sequence of keys)
- [x] Image management `simple`
  - [x] Render image on screen
  - [x] Save images
  - [ ] JPG/SVG/BMP formats
  - [ ] More Image manipulation features
    - [ ] Resize images
    - [ ] Nesting Image type into each other
- [x] Text management
  - [x] Drawing text on screen
    - [ ] Size properties
    - [ ] More advanced features (multiline text)
  - [x] Font support
- [ ] QoL
  - [ ] Holders for images/rects/sounds that let you access them by ID from Window
  <!-- use .mitems() for iterating over loop while making vars mutable
       can be pretty beneficial for iterating over holder items -->
- [ ] Sound management
  - [ ] Playing & stopping sound
  - [ ] WAV/FLAC/OGG/MP3 formats
  - [ ] Managing multiple channels (parallel sounds playing)
- [ ] UI
  - [x] Buttons
  - [x] Progress bars
  - [ ] Sliders (vertical/horizontal)
  - [ ] Scrolling slider (vertical/horizontal)
  - [ ] Text fields
    - [ ] Single-row box
    - [ ] Multi-row box
  - [ ] Lists
    - [ ] Comboboxes
    - [ ] Bulletboxes
    - [ ] Listboxes
- [ ] QoL abstractions
  - [ ] Delta clock object
  - [ ] Optional Event system

Look at [changelog](changelog.md) if you want to see details.

---
### Note
Nimfire is learning project, and as such, may contain more bugs, performance issues
and problems overall than matured library.  
It is by no means stable or ready for development of games or software, and I hold
no promise to maintain it if I lose my motivation and will.

That said, I really want to do as much as I can with Nimfire, so it's not like this
lib will disappear soon. Just take in mind that until it becomes important utility
for my own gamedev, I do it as fun side-project, with all good and bad coming with
such status.

---
### Socials

<tr>
        <td colspan="2" align="center">
            <a href="https://linktr.ee/toma400"><img src="https://img.shields.io/badge/%20-Linktree%20-108931?style=plastic&logo=appveyor"></a>
            <a href="https://discord.gg/GbTw9KqnrE"><img src="https://img.shields.io/discord/842338281692725268?color=AA16D1&label=%20&logo=Discord&logoColor=DDD4EA&style=plastic"></a>
        </td>
</tr>

### Licensing
While library code is *All Rights Reserved* for now (I'm quite lazy for licenses),
it will be changed soon. For now you are allowed to use the library for any personal
project that is not commercial in any way.

Library fonts use [Open Font License](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)
which permits their use. They can be used in project of any kind, but please refer
to license or your lawyer if you want to be sure.

### Project made using Nimfire
#### 🎨 [Drawfire](https://github.com/Toma400/Drawfire) - simple drawing app

<!-- TODO
  - listening to sequence of keys (see TODO)
    - there could be OrderedSet/seq that would store strings
    - there would be arg that would be 'duration before reset' with default being -1 (infinite)
       - each tick would count from 'duration' down
       - clicking on keyboard input would bring 'duration' clock back + append string
       - if 'duration' gets to 0, it would reset string

  - nested rects (for GUI)
    // - I'd say it should be exactly 'ref of Rect' with new addition being
         dict/list of rects inside & special drawing system that calls drawing
         of inside rects afterwards and with relative position
    // - a way to nest Rects inside Rects? (needs adjusting matrix accordingly)
  - simplegui button
  - simplegui progress bar
    - can have custom range, so if given 10_000, it'd make 10_000/100 and use it?
    - should have non-manual 0<x<100 control at least as an option
  - text using Pixie's "fillText" with possibility to have clear borders
    (https://github.com/treeform/pixie/tree/523b364fcaa288d23ecb3f34c795da97d3637117#text)
    + look at textspans, as they would be neat both for Nimfire & MarXDown
      (https://github.com/treeform/pixie/tree/523b364fcaa288d23ecb3f34c795da97d3637117#text-spans)
    + text could not have default size or customised one, but one adjusting to Rect
      (or make two variants, one with auto-Rect and one with auto-size, with opposite
       one being customisable)

  - resize image
  - jpg & svg & bmp formats supported?

  - creating button (nimfire/ui) that is manageable?
    - creating 'buttons' element in Window that button can subscribe to?
      this way you could not need variables to be passed, as you would
      simply manage it by calling from Window object by ID or sth
  - getting sound and letting it play (possibly on several channels, so they
    can be played together and managed by it?)
    ::: https://github.com/oprypin/nim-csfml
    ::: https://github.com/treeform/openal (pure Nim!)
    ::: https://github.com/treeform/slappy (OpenAL wrapper? More C!)
  - holders for Image, Rect and other elements via either Window or
    separate structure? Would work as Table of [ID:str, T] and could
    handle objects for further reference
-->