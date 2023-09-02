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
   Last addition to game adds movement for enemies - this let you
   incentivise player to move.
   As previously, movement of rectangles will be random, but to try
   avoid them go out of window, we will make them respawn whenever
   they go out of window                                         ]#

# function to make spawning code less verbose
proc spawnPos(): (int, int) =
    return (rand(100..700), rand(100..600))

# initialises window
var w = initWindow((800, 600), "Dance or Die", resizable=true, bg_colour=PULLMAN_BROWN)
# player-related variables
var r      = newRect((25, 25), (10, 10), PINE_GREEN) # player Rect
var poison = 0                                       # whether player is poisoned
# enemey-related variables
  # we use spawnPos() for less verbose code
var en1 = newRect(pos=spawnPos(), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en2 = newRect(pos=spawnPos(), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en3 = newRect(pos=spawnPos(), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en4 = newRect(pos=spawnPos(), size=(rand(30..50), rand(30..50)), colour=BLOOD)
var en5 = newRect(pos=spawnPos(), size=(rand(30..50), rand(30..50)), colour=BLOOD)

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
        poison += 9 # we can adjust poison to last longer

    # we create movement for enemies
    en1.move(rand(-7..7), rand(-7..7)) # we can adjust position moves to be faster or slower
    en2.move(rand(-5..5), rand(-2..2))
    en3.move(rand(-2..2), rand(-5..5)) # we can also make Rects moving more in specific axes
    en4.move(rand(-5..5), rand(-2..2))
    en5.move(rand(-2..2), rand(-5..5))

    if poison > 0:
        r.size = (r.size[0] - 1, r.size[1] - 1)
        r.colour = sample([YELLOW, ORANGE])
        poison -= 1
    else:
        r.colour = PINE_GREEN

    # check if enemy Rects are in window range, and respawn them if not
    if not en1.isWithin(w):
      en1.pos = spawnPos()
    if not en2.isWithin(w):
      en2.pos = spawnPos()
    if not en3.isWithin(w):
      en3.pos = spawnPos()
    if not en4.isWithin(w):
      en4.pos = spawnPos()
    if not en5.isWithin(w):
      en5.pos = spawnPos()

    # checks if size of player Rect is bigger than (0, 0)
    if r.size[0] < 1 or r.size[1] < 1:
        break
    w.update() # updates the screen
w.finish() # finishes the game