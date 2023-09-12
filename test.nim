import nimfire/indev/simpleui
import nimfire/indev/text
import nimfire/colors
import nimfire/input
import nimfire

var w = initWindow((800, 600), "Dance or Die - Simple Game", resizable=true, bg_colour=PULLMAN_BROWN)
var e = newProgressBar((5, 5), (500, 50))
var f = newText("Hello world", size=35, pos=(150, 150), bsize=(300, 300))
var p = 100

while w.tick():
    w.drawProgressBar(e, progress=p)
    w.drawText(f)

    if getKeyPressed(w, KEY.W):
        p -= 1

    echo p

    w.update()

w.finish()