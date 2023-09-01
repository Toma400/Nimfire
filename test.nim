import nimfire/colors
import nimfire/draw
import nimfire/input
import nimfire

var w = initWindow((800, 600), "Nimfire", resizable=true, bg_colour=LIME)
var r1 = newRect((50, 50), (50, 50), LEMON_LIME)

# update loop
while w.tick():
    drawRect(w, r1)

    # echo $getMousePos(w)
    # echo getMousePos(w)

    w.update() # updates the screen
w.finish() # finishes the game