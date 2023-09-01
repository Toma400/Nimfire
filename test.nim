import nimfire/colors
import nimfire/input
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)

# update loop
while w.tick():
    if allKeysPressed(w, K, E):
        echo "!!"
    if anyKeysPressed(w, I, O, P):
        echo "???"

    w.update() # updates the screen
w.finish() # finishes the game