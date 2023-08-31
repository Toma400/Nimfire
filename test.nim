import nimfire/colors
import nimfire

var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)

while w.tick():
  w.update()
w.finish()

# aliased

var e = ignite((800, 600), "Nimfire", bg_colour=PURPLE)

if w.isBurning():
  w.addWood()
w.extinguish()