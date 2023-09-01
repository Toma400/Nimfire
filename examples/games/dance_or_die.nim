import nimfire/colors
import nimfire/input
import nimfire/draw
import nimfire

#[ --- DANCE OR DIE ----------------------------------------------
   Game is fairly simple: you move with WASD/arrows, and whenever
   you do, you get tinier. To counter this, you need to use
   space to grow in size.
   However if you grow too big, you will eventually crash the game
   Have fun!                                                    ]#

# initialises window
var w = initWindow((800, 600), "Nimfire", true, bg_colour=PURPLE)
# creates "player" rectangle
var r = newRect((25, 25), (10, 10), COMEX_CAOBA)

# update loop
while w.tick():
    w.drawRect(r) # draws player
    if getKeyPressed(w, KEY.A) or getKeyPressed(w, KEY.LEFT): # check for keys (WASD)
        r.pos  = (r.pos[0] - 1, r.pos[1])                       # adjusts their position
        r.size = (r.size[0] - 1, r.size[1] - 1)                 # and shrinks size of player
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
        r.size = (r.size[0] + 1, r.size[1] + 1)  # grows size of player (when SPACE is pressed)
    # checks if size of player Rect is bigger than (0, 0)
    if r.size[0] < 1 or r.size[1] < 1:
      break
    w.update() # updates the screen
w.finish() # finishes the game