import nimfire/colors
import nimfire/input
import nimfire/draw
import nimfire

var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)
var r = newRect((25, 25), (10, 10), COMEX_CAOBA)

while w.tick():
  w.drawRect(r)
  if getKeyPressed(w, KEY.A) or getKeyPressed(w, KEY.LEFT):
      r.pos  = (r.pos[0] - 1, r.pos[1])
      r.size = (r.size[0] - 1, r.size[1] - 1)
  if getKeyPressed(w, KEY.D) or getKeyPressed(w, KEY.RIGHT):
      r.pos  = (r.pos[0] + 1, r.pos[1])
      r.size = (r.size[0] - 1, r.size[1] - 1)
  if getKeyPressed(w, KEY.W) or getKeyPressed(w, KEY.UP):
      r.pos  = (r.pos[0], r.pos[1] - 1)
      r.size = (r.size[0] - 1, r.size[1] - 1)
  if getKeyPressed(w, KEY.S) or getKeyPressed(w, KEY.DOWN):
      r.pos  = (r.pos[0], r.pos[1] + 1)
      r.size = (r.size[0] - 1, r.size[1] - 1)
  if getKeyPressed(w, KEY.SPACE):
      r.size = (r.size[0] + 1, r.size[1] + 1)

  if r.size[0] < 1 or r.size[1] < 1:
      break
  w.update()
w.finish()