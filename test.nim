import nimfire/colors
import nimfire/input
import nimfire/image
import nimfire/draw
import nimfire

# initialises window
var w = initWindow((800, 600), "Dance or Die", resizable=true, bg_colour=PULLMAN_BROWN)
var i = newImage("nimfire.png", (10, 10))
var r = newRect((50, 50), (50, 50), BLACK).toImage()

while w.tick():
    w.drawImage(i)
    w.drawImage(r)
    if getKeyPressed(w, W):
      move(i, 0, -1)
    if getKeyPressed(w, S):
      move(i, 0, 1)
    if getKeyPressed(w, A):
      move(i, -1, 0)
    if getKeyPressed(w, D):
      move(i, 1, 0)

    # if getMousePressed(w, LEFT):
    #   echo getMousePos(w)

    w.update() # updates the screen
w.finish() # finishes the game