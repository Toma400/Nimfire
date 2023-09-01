![](banner.png)
**Nimfire** (Nim Campfire) is small GUI/game library inspired by PyGame, using
gl*FB library to render window and let you draw.  
While it is mostly my learning project, I'd love to see it becoming something bigger
in the future - I will try to update is regularly, so it should not be abandoned
anytime soon.

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

Also, Nimfire has possibility to handle user input:
```nim
import nimfire/input
import nimfire

var w = initWindow((800, 600), "Nimfire")

while w.tick():
  if w.getKeyPressed(KEY.SPACE):
    echo "Space just got used!"
  w.update()
  
w.finish()
```

---
For code examples, visit `examples` folder.

### Note
All files are up for testing, however following modules:
- `nimfire/ui`

are experimental and as such, their behaviour should not be reported as buggy, as
it is very much expected, being still worked on.

### Licensing
While library is *All Rights Reserved* for now (I'm quite lazy for libraries), it will
be changed soon. For now you are allowed to use the library for any personal project
that is not commercial in any way.

<!-- CHANGELOG
0.1.0:
  - added basic Window handler
  - added colors
  - added drawing shapes
  - added several utility procs
-->
<!-- TODO
  - getting keyboard event
  - getting mouse position and clicking event
  - getting image and drawing it on screen
    (getting image as array of pixels and doing it manually?)

  - creating button (nimfire/ui) that is manageable?
    - creating 'buttons' element in Window that button can subscribe to?
      this way you could not need variables to be passed, as you would
      simply manage it by calling from Window object by ID or sth
  - getting sound and letting it play (possibly on several channels, so they
    can be played together and managed by it?)
    ::: https://github.com/oprypin/nim-csfml
-->