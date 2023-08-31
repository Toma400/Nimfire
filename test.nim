import nimfire/colors
import nimfire/utils
import nimfire/draw
import nimfire/ui
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)
var b = newButton(p(w, 2, 2), p(w, 15, 10), "Some text", TEAL, pax(w, 1, 1), BLACK)

while w.tick():
  w.drawRect(p(w, 50, 50), pax(w, 30, 30), TEAL)
  drawButton(w, b)
  w.update()
w.finish()