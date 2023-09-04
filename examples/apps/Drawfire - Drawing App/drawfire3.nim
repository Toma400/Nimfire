import nimfire/colors
import nimfire/input
import nimfire/types # required for 'brushDraw' proc
import nimfire/draw
import nimfire
import os

# DRAWFIRE 3
# Here we will add new brushes and make user be able to switch between them!

var w  = initWindow((1200, 800), "Drawfire", bg_colour=GREEN)
var cr = newRect(pos=(50, 50), size=(50, 50), BLACK)

var brush = 1 # size of a brush
# but we can make more brush shapes!
type
  BRUSHES = enum  # we make enum, so it's easier for us to switch brushes
    SLASH, SQUARE, CROSS
var brush_type = SLASH # let's make SLASH as default type

# then, we make procedures in style of previous 'brushDraw':
# '\' slash
proc brushDrawSlash(w: var Window, pos: (int, int)) =  # -var- Window because it is required by fillPos
  for i in -brush..brush:
    let x = pos[0] + i  # making both x and y follow the same 'i' makes them go in slash shape
    let y = pos[1] + i
    w.fillPos((x, y), cr.colour)

# square
proc brushDrawSquare(w: var Window, pos: (int, int)) =
  for i in -brush..brush:       # setting two loops let us cover square shape instead (kinda like x/y)
    for j in -brush..brush:
      let x = pos[0] + i
      let y = pos[1] + j  # we change our '+ i' into separate variable for each axis
      w.fillPos((x, y), cr.colour)

# cross
proc brushDrawCross(w: var Window, pos: (int, int)) =
  for i in -brush..brush:        # setting cross shape requires us to keep one axis unaffected
    let x = pos[0] + i
    let y = pos[1]
    w.fillPos((x, y), cr.colour)
  for j in -brush..brush:        # and then do the same for second iteration, but reversely
    let x = pos[0]
    let y = pos[1] + j
    w.fillPos((x, y), cr.colour)


while w.tick():
  w.drawRect(cr) # draws Rect showing current colour

  if w.getKeyPressed(KEY.B):
    cr.setColour(BLACK) # .setColour is performance-heavy operation, so we need to be careful
                        # to not use it too often (conditioning it with pressing key should be okay)
  elif w.getKeyPressed(KEY.G):
    cr.setColour(GREEN)
  elif w.getKeyPressed(KEY.R):
    cr.setColour(RED)
  elif w.getKeyPressed(KEY.W):
    cr.setColour(WHITE)
  elif w.getKeyPressed(KEY.L):
    cr.setColour(BLUE)
  elif w.getKeyPressed(KEY.Y):
    cr.setColour(YELLOW)
  elif w.getKeyPressed(KEY.P):
    cr.setColour(PURPLE)
  elif w.getKeyPressed(KEY.Q):
    w.clear()
  elif w.getKeyPressed(KEY.UP):   # we add two new options: changing size of a brush up and down
    brush += 1
  elif w.getKeyPressed(KEY.DOWN):
    if brush > 1:
      brush -= 1
  elif w.getKeyPressed(KEY.LEFT):
    case brush_type:                      # we make a bit primitive, but valid 'case' to switch brushes
      of SLASH:  brush_type = SQUARE
      of SQUARE: brush_type = CROSS
      of CROSS:  brush_type = SLASH
  elif w.getKeyPressed(KEY.RIGHT):
    case brush_type:                      # we make a bit primitive, but valid 'case' to switch brushes
      of SLASH:  brush_type = CROSS
      of SQUARE: brush_type = SLASH
      of CROSS:  brush_type = SQUARE

  # drawing with mouse
  if w.getMousePressed(LEFT):
    var pos = w.getMousePos()
    # we use 'case' to set currently used brush
    case brush_type:
      of SLASH:  brushDrawSlash(w, pos)
      of SQUARE: brushDrawSquare(w, pos)
      of CROSS:  brushDrawCross(w, pos)

  w.update(manual=true)

w.finish()