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

---
For code examples, visit `examples` folder.

### Licensing
While library is *All Rights Reserved* for now (I'm quite lazy for libraries), it will
be changed soon. For now you are allowed to use the library for any personal project
that is not commercial in any way.

<!-- CHANGELOG
0.1.0:
  - added basic Window handler
  - added colors
  - added drawing of shapes
  - added several utility procs
-->