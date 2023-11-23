import nimfire/indev/collection
import nimfire/indev/simpleui
import nimfire/indev/decorui
import nimfire/colors
import nimfire/input
import nimfire/image
import nimfire/draw
import nimfire/pc
import nimfire

var w = initWindow((800, 600), "Nimfire Test", resizable=true, bg_colour=PULLMAN_BROWN)

var e = newProgressBar((5, 5), (500, 50), range=(0, 200), bg_col=CREAM, progress_col=PURPLE)
var f = newDecorButton((100, 100), newImage("test1.png"), newImage("test2.png"))
var p = 100

var a = newImage("test1.png", (400, 400))
var b = newImage("test2.png", (400, 500))
var c = newCollection(a, b)

while w.tick():
    w.drawProgressBar(e, progress=p)
    w.drawDecorButton(f)
    w.drawCollection(c)

    if isClickedListener(w, f):
      p -= 1
      c.remove(1)

    echo p

    w.update()

w.finish()