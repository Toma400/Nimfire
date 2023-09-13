import nimfire/indev/simpleui
import nimfire/indev/decorui
import nimfire/colors
import nimfire/image
import nimfire

var w = initWindow((800, 600), "Nimfire Test", resizable=true, bg_colour=PULLMAN_BROWN)
var e = newProgressBar((5, 5), (500, 50), bg_col=CREAM, progress_col=PURPLE)
var f = newDecorButton((100, 100), newImage("test1.png"), newImage("test2.png"))
var p = 100

while w.tick():
    w.drawProgressBar(e, progress=p)
    w.drawDecorButton(f)

    if isClickedListener(f, w):
      p -= 1

    echo p

    w.update()

w.finish()