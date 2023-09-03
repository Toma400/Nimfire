import nimfire/colors
import nimfire/input
import nimfire/image
import nimfire/draw
import nimfire

# initialises window
var w = initWindow((800, 600), "Dance or Die - Simple Game", resizable=true, bg_colour=PULLMAN_BROWN)
#var i = newImage("nimfire.png", (0, 1))
var i = newRect((0,0), (50, 50), BLUE)
var p = newRect((50, 50), (50, 50), RED)
var r = newRect((100, 100), (200, 200), BLACK)
i.matrix = createMatrix(i)
p.matrix = createMatrix(p)
r.matrix = createMatrix(r)

while w.tick():
    w.drawRect(i)
    w.drawRect(p)
    w.drawRect(r)

    w.update() # updates the screen
w.finish() # finishes the game