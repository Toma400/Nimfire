import nimfire/colors
import nimfire/utils
import nimfire/draw
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)

while w.tick():
  w.drawRect(p(w, 50, 50), pax(w, 30, 30), CHETWODE)
  w.update()
w.finish()