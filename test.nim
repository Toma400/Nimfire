import nimfire/indev/collection
import nimfire/indev/simpleui
import nimfire/indev/decorui
import nimfire/colors
import nimfire/input
import nimfire/draw
import nimfire/pc
import nimfire

var w = initWindow((800, 600), "Nimfire Test", resizable=true, bg_colour=PULLMAN_BROWN)

var wall_a = newRect((0, 0),  (10, 10), PINE_GREEN).toImage
var wall_b = newRect((10, 0), (10, 10), PINE_GREEN).toImage
var wall_c = newRect((20, 0), (10, 10), PINE_GREEN).toImage
var wall_d = newRect((30, 0), (10, 10), PINE_GREEN).toImage
var wall_e = newRect((40, 0), (10, 10), PINE_GREEN).toImage
var wall_f = newRect((50, 0), (10, 10), PINE_GREEN).toImage
var wall_g = newRect((60, 0), (10, 10), PINE_GREEN).toImage
var walls  = newCollection(wall_a, wall_b, wall_c, wall_d, wall_e, wall_f, wall_g)
# var e = newProgressBar((5, 5), (500, 50), bg_col=CREAM, progress_col=PURPLE)
# var f = newDecorButton((100, 100), newImage("test1.png"), newImage("test2.png"))
# var p = 100

while w.tick():
    # w.drawProgressBar(e, progress=p)
    # w.drawDecorButton(f)
    #
    # if isClickedListener(w, f):
    #   p -= 1
    #
    # echo p

    drawCollection(w, walls)

    if collide(walls, getMousePos(w)):
      echo getMousePos(w)

    w.update()

w.finish()