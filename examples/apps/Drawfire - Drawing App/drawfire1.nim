import nimfire/colors
import nimfire/input
import nimfire/draw
import nimfire

var w  = initWindow((1200, 800), "Drawfire", bg_colour=GREEN)  # creates window with green background
var c  = BLACK                                                 # current colour
var cr = newRect(pos=(50, 50), size=(50, 50), c)               # rect showing current colour
                                                                # we will use cr.colour
                                                                # from now on, as it will
                                                                # update more easily

while w.tick():
  w.drawRect(cr) # draws Rect showing current colour

  # using keyboard, we change colour
  if w.getKeyPressed(KEY.B):
    cr.setColour(BLACK) # .setColour is performance-heavy operation, so we need to be careful
                        # to not use it too often (conditioning it with pressing key should be okay)
  elif w.getKeyPressed(KEY.G):
    cr.setColour(GREEN)
  elif w.getKeyPressed(KEY.R):
    cr.setColour(RED)
  elif w.getKeyPressed(KEY.W):
    cr.setColour(WHITE)
  elif w.getKeyPressed(KEY.L):
    cr.setColour(BLUE)
  elif w.getKeyPressed(KEY.Y):
    cr.setColour(YELLOW)
  elif w.getKeyPressed(KEY.Q):
    w.clear()

  # drawing with mouse
  if w.getMousePressed(LEFT):   # takes mouse event
    var pos = w.getMousePos()   # and mouse position
    w.fillpos(pos, cr.colour)   # updates the screen with colour

  w.update(manual=true) # manual=true is important as it let you update Window background manually
                         # additionally, it makes app more performant as you don't need to
                         # redraw background every tick

w.finish()