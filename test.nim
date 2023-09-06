import nimfire/colors
import nimfire/image
import nimfire/draw
import nimfire

var w = initWindow((800, 600), "Dance or Die - Simple Game", resizable=true, bg_colour=PULLMAN_BROWN)
var i = newImage("nimfire.png", (50, 50)).toRect

for x in 0..10:
  setPixel(i, (x, 5), BLACK)

while w.tick():
    w.drawRect(i)
    w.update(true)

w.finish()