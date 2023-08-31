import nimfire/colors
import nimfire/utils
import nimfire/draw
import nimfire/ui
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)
var b = newButton(p(w, 2, 2), p(w, 15, 10), "Some text", TEAL, pax(w, 1, 1), CREAM)
var counter = 0

while w.tick():
  w.drawRect(p(w, 50, 50), pax(w, 30, 30), BAIKO)
  drawButton(w, b)
  counter += 1
  if counter == 100:
      b.moveButton((100, 100))
  w.update()
w.finish()