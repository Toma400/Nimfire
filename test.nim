import nimfire/colors
import nimfire/input
import nimfire/image
import nimfire/draw
import nimfire

# initialises window
var w = initWindow((800, 600), "Dance or Die - Simple Game", resizable=true, bg_colour=PULLMAN_BROWN)
var i = newImage("2057521.png")

while w.tick():
    w.drawImage(i)

    if collidePrecise(i, getMousePos(w)):
        echo "!!!"

    w.update(true) # updates the screen
w.finish() # finishes the game