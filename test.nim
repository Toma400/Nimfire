import nimfire/colors
import nimfire/input
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)

# update loop
while w.tick():
    if getMousePressed(w, LEFT):
        echo "Siema!"

    # echo $getMousePos(w)
    # echo getMousePos(w)

    w.update() # updates the screen
w.finish() # finishes the game