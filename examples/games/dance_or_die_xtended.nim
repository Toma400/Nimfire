import nimfire/colors
import nimfire/input
import nimfire/draw
import nimfire

#[ --- DANCE OR DIE ----------------------------------------------
   Game is fairly simple: you move with WASD/arrows, and whenever
   you do, you get tinier. To counter this, you need to use
   space to grow in size.
   However if you grow too big, you will eventually crash the game

   EXTENDED VERSION
   Extended version adds also "enemy" rectangles that you should
   not touch, as they also shrink you!                           ]#

# initialises window
var w = initWindow((800, 600), "Dance or Die", true, bg_colour=PURPLE)
# creates "player" rectangle
var r = newRect((25, 25), (10, 10), PINE_GREEN)
# creates "enemy" rectangles
var en1 = newRect((45, 45),   (30, 30), BLOOD)
var en2 = newRect((550, 300), (30, 30), BLOOD)
var en3 = newRect((700, 120), (30, 30), BLOOD)
var en4 = newRect((80,  460), (40, 40), BLOOD)
var en5 = newRect((200, 230), (40, 40), BLOOD)

# update loop
while w.tick():
    w.drawRect(r)   # draws player
    w.drawRect(en1) # draws enemies
    w.drawRect(en2)
    w.drawRect(en3)
    w.drawRect(en4)
    w.drawRect(en5)
    if getKeyPressed(w, KEY.A) or getKeyPressed(w, KEY.LEFT): # check for keys (WASD)
        r.move(-1, 0)                                           # adjusts Rect position
        r.size = (r.size[0] - 1, r.size[1] - 1)                 # and shrinks size of it
    if getKeyPressed(w, KEY.D) or getKeyPressed(w, KEY.RIGHT):
        r.move(1, 0)
        r.size = (r.size[0] - 1, r.size[1] - 1)
    if getKeyPressed(w, KEY.W) or getKeyPressed(w, KEY.UP):
        r.move(0, -1)
        r.size = (r.size[0] - 1, r.size[1] - 1)
    if getKeyPressed(w, KEY.S) or getKeyPressed(w, KEY.DOWN):
        r.move(0, 1)
        r.size = (r.size[0] - 1, r.size[1] - 1)
    if getKeyPressed(w, KEY.SPACE):
        r.size = (r.size[0] + 1, r.size[1] + 1)  # grows size of player (when SPACE is pressed)
    # checks if player Rect doesn't touch enemies - if it does, it shrinks player
    if r.collide(en1) or r.collide(en2) or r.collide(en3) or r.collide(en4) or r.collide(en5):
        r.size = (r.size[0] - 1, r.size[1] - 1)
    # checks if size of player Rect is bigger than (0, 0)
    if r.size[0] < 1 or r.size[1] < 1:
        break
    w.update() # updates the screen
w.finish() # finishes the game