import nimfire/colors
import nimfire/draw # import to get Rect type and all functions related to it
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)
var r = newRect((25, 25), (10, 10), COMEX_CAOBA) # creates new Rect object
var y = newRect((50, 50), (15, 15), COMEX_CAOBA)

var is_moved   = false

while w.tick():
  w.drawRect(r) # draws Rect object on screen

  if is_moved == false:
    r.move(10, -5)     # move() let you change position of rectangle from its current one
    
  # to change its position or size, you need to use Rect fields:
  r.pos  = (60, 60)   # sets new coordinates
  r.size = (20, 20)   # sets new size
  r.colour = BLUE     # sets new colour
  
  if r.collide(15, 15): # you can check whether Rect collides with specific position
    echo "Rectangle -r- collides with (15, 15)!"
  if r.collide(y):      # and you can check whether Rect collides with another Rect (it doesn't need to be drawn!)
    echo "Rectangle -r- collides with Rectangle -y-!"
    
  w.update()
w.finish()