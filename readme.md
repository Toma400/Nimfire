![](banner.png)
**Nimfire** (Nim Campfire) is small GUI/game library inspired by PyGame and Nigui,
using gl*FB and GLFW libraries to render window and let you draw.  
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
You can look at `examples/drawing` and `examples/rect_management` for more detailed
documentation on how you can use drawing with the library.

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
Again, if you want to see more detailed documentation, `examples/keyboard_input` and
`examples/mouse_input` are great place to start!

---
### Note
For more code examples, visit `examples` folder. You can also look at `examples/games`
for tutorial games.

All files are up for testing, however following modules:
- `nimfire/ui`

are experimental and as such, their behaviour should not be reported as buggy, as
it is very much expected, being still worked on.

---
### Discord server

<a href="https://discord.gg/GbTw9KqnrE"><center>
<img src="https://cdn.discordapp.com/attachments/849205834830315520/863457019742519328/Discord_logo_okrage.png" width="200"></center>
</a>

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
  - added handling of keyboard & mouse clicking
-->
<!-- TODO
  - getting mouse position
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