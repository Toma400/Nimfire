import nimfire/colors
import nimfire/input
import nimfire/draw
import nimfire
import random

randomize()

#[ --- DANCE OR DIE ----------------------------------------------
   Game is fairly simple: you move with WASD/arrows, and whenever
   you do, you get tinier. To counter this, you need to use
   space to grow in size.
   However if you grow too big, you will eventually crash the game

   EXTENDED VERSION
   This update adds poison system - in which whenever you touch
   enemy, you got effect shrinking you
   This makes it harder to survive since you need to actually
   avoid enemies instead of just them blocking you              ]#

# initialises window
var w = initWindow((800, 600), "Dance or Die - Simple Game", resizable=true, bg_colour=PULLMAN_BROWN)
# player-related variables
var r      = newRect((25, 25), (10, 10), PINE_GREEN) # player Rect
var poison = 0                                       # whether player is poisoned
# enemey-related variables
#   we change position and size of rectangles to be random
var en1 = newRect(pos=(rand(100..700), rand(100..600)), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en2 = newRect(pos=(rand(100..700), rand(100..600)), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en3 = newRect(pos=(rand(100..700), rand(100..600)), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en4 = newRect(pos=(rand(100..700), rand(100..600)), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en5 = newRect(pos=(rand(100..700), rand(100..600)), size=(rand(30..50), rand(30..50)), colour=BLOOD)

# update loop
while w.tick():
    w.drawRect(r)     # draws player
    w.drawRect(en1)
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
        poison += 5

    if poison > 0:
        r.size = (r.size[0] - 1, r.size[1] - 1)
        r.colour = sample([YELLOW, ORANGE])
        poison -= 1
    else:
        r.colour = PINE_GREEN

    # checks if size of player Rect is bigger than (0, 0)
    if r.size[0] < 1 or r.size[1] < 1:
        break
    w.update() # updates the screen
w.finish() # finishes the game