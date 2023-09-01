import nimfire/colors
import nimfire/input # let you use keyboard input
import nimfire/draw # draw let you use drawing functions
import nimfire

# initialises Window object
var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)

# we can create Rect object, so it will be easier for us to change coordinates of rectangle
var r = newRect(pos=(150, 150), size=(150, 150), colour=BLACK)

while w.tick():
  w.drawRect(r)   # we draw our Rect object

  if getKeyPressed(w, KEY.A):            # we check if button is pressed
      r.pos = (r.pos[0] - 1, r.pos[1])     # then move our Rect accordingly by (X, Y)
  if getKeyPressed(w, KEY.D):
      r.pos = (r.pos[0] + 1, r.pos[1])
  if getKeyPressed(w, KEY.W):
      r.pos = (r.pos[0], r.pos[1] - 1)
  if getKeyPressed(w, KEY.S):
      r.pos = (r.pos[0], r.pos[1] + 1)

  w.update()

w.finish() # finish program