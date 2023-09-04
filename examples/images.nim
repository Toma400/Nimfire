import nimfire/colors
import nimfire/image
import nimfire/draw # used for Rect conversion
import nimfire

# initialises Window object
var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)
# we create Image objects by passing either only path
var i1 = newImage("nimfire.png")
# or with explicit coordinates (if they are not passed, default (0, 0) is used)
var i2 = newImage("nimfire.png", (25, 25))

while w.tick():
  w.drawImage(i1, (55, 55)) # we can pass coordinates later
  w.drawImage(i2) # or not - if they are not passed anywhere, Image will draw on (0, 0)

  i1.move(10, 15) # similarly to Rect, you can move images with 'move(int, int)' proc

  # currently, Nimfire supports only .png format, but this will change shortly

  # you can also convert Rect into Image
  var r1 = newRect((0, 0), (50, 50), BLACK)
  var i3 = r1.toImage()

  # Image can be saved as PNG file (so
  saveImage(i3, "example_file.png")

  w.update()

w.finish() # finish program