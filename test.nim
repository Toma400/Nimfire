import nimfire/colors
import nimfire/draw
import nimfire/utils
import nimfire

var w = initWindow((800, 600), "Dance or Die - Simple Game", resizable=true, bg_colour=PULLMAN_BROWN)
var y = newRect((0, 0), (10, 10), BLACK)
var z = newRect((10, 10), (10, 10), RED)

echo getScreenRes()

var list = @[y, z]

while w.tick():
    for i in list:
      w.drawRect(i)
    w.update(true)

w.finish()