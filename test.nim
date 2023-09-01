import nimfire/colors
import nimfire/draw # import to get Rect type and all functions related to it
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)
var r = newRect((25, 25), (40, 40), COMEX_CAOBA) # creates new Rect object
var y = newRect((50, 50), (15, 15), BLOOD)

var is_moved   = false

while w.tick():
  w.drawRect(r) # draws Rect object on screen
  w.drawRect(y)

  if r.collide(35, 25): # you can check whether Rect collides with specific position
    echo "Rectangle -r- collides with (15, 15)!"
  if r.collide(y):      # and you can check whether Rect collides with another Rect (it doesn't need to be drawn!)
    echo "Rectangle -r- collides with Rectangle -y-!"

  w.update()
w.finish()