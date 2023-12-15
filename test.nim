import nimfire/indev/collection
import nimfire/indev/collision
import nimfire/indev/simpleui
import nimfire/indev/decorui
import nimfire/colors
import nimfire/input
import nimfire/image
import nimfire/draw
import nimfire/pc
import nimfire

var w = initWindow((800, 600), "Nimfire Test", resizable=true, bg_colour=PULLMAN_BROWN)

const jump = 50
const move = 30

var player = newRect((30, 100), (50, 50), GRAY).toImage
var a = newImage("test1.png", (0, 400))
var b = newImage("test2.png", (300, 400))
var c = newDecorButton((500, 0), newImage("test1.png"), newImage("test2.png"))

var solids = newCollection(a, b)

while w.tick():
    w.drawCollection(solids)
    w.drawImage(player)
    w.drawDecorButton(c)

    gravity(player, solids, jump)

    if getKeyPressed(w, KEY.W):
      if getKeyPressed(w, KEY.A):
        collideMove(player, solids, -move, -jump)
      elif getKeyPressed(w, KEY.D):
        collideMove(player, solids, move, -jump)
      else:
        collideMove(player, solids, 0, -jump)
    elif getKeyPressed(w, KEY.A):
      collideMove(player, solids, -move, 0)
    elif getKeyPressed(w, KEY.D):
      collideMove(player, solids, move, 0)

    w.update()

w.finish()