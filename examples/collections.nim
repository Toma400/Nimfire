import nimfire/indev/collection # we import collections
import nimfire/colors
import nimfire/input
import nimfire/draw # we could import nimfire/image instead, but we will use Rect converted to Image
import nimfire

var w = initWindow((800, 600), "Collections Tutorial", bg_colour=PULLMAN_BROWN)

# Collections are very interesting concept that allows you to bulk-manage multiple Image objects at once
#  This can get handy for bulk drawing, collision detection or any other effect
#  You can consider this to allow you for categorising Image objects

# we make various objects
var wall_a = newRect((0, 0),  (10, 10), PINE_GREEN).toImage
var wall_b = newRect((10, 0), (10, 10), PINE_GREEN).toImage
var wall_c = newRect((20, 0), (10, 10), PINE_GREEN).toImage
var wall_d = newRect((30, 0), (10, 10), PINE_GREEN).toImage
var wall_e = newRect((40, 0), (10, 10), PINE_GREEN).toImage
var wall_f = newRect((50, 0), (10, 10), PINE_GREEN).toImage
var wall_g = newRect((60, 0), (10, 10), PINE_GREEN).toImage
# and collection to manage them
var walls  = newCollection(wall_a, wall_b, wall_c, wall_d, wall_e, wall_f, wall_g)

while w.tick():
    # we perform mass drawing of all collection elements
    drawCollection(w, walls)

    # and we can also mass check for collisions
    if collide(walls, getMousePos(w)):
      echo getMousePos(w)

    w.update()

w.finish()