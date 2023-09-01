import nimfire/colors
import nimfire/input # let you use mouse input
import nimfire

# initialises Window object
var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)

while w.tick():
  if getMousePressed(w, LEFT): # you can check if specific mouse button was pressed by 'getMousePressed'
      echo "Left mouse button was clicked!"

  w.update()

w.finish() # finish program