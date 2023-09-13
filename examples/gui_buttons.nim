#[ important note!
   while this example is made for tutorial reasons and is kept with other
   examples here, GUI use is currently experimental feature and should be
   treated as such - in upcoming releases its behaviour or locations will
   most likely change ]#

import nimfire/indev/decorui # in later releases it will be nimfire/decorui
import nimfire/colors
import nimfire/image         # we need either nimfire/image of nimfire/draw
import nimfire               #   to be used within nimfire/decorui

var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)
# here, we create decor button object - "decor" means that it allows for more customisation
#              you pass coordinates here
#                              |    image showcased when button is inactive
#                              |                  |           and when it is active
#                              |                  |                      |
#                              V                  V                      V
var button = newDecorButton((100, 100), newImage("test1.png"), newImage("test2.png"))
# you can do it by passing Image objects initialised elsewhere, but you can do it within button constructor as well

while w.tick():
  w.drawDecorButton(button) # we then pass drawing command to main loop

  setListener(w, button) # we need to create listener, so button will recognise being clicked and change its state
                         # it mostly help with correct rendering of button state, it doesn't affect isClicked proc

  if isClicked(w, button): # isClicked proc let you recognise whether button was clicked
    echo "Hello world!"

  # using separate setListener and isClicked is slightly expensive on performance, so if you want to use
  # isClicked only once, you can use bundled proc
  if isClickedListener(w, button):
    echo "Another hello world!"
  # this one optimises performance and takes care of both rendering and boolean return
  # however!
  # if you want to use isClicked several times, it's better to keep setLister and isClicked separate

  w.update()

w.finish()