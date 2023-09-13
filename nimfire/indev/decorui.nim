import ../image
import ../input
import ../types

type
  DecorButton = object
    un_image : Image      # unclicked
    ac_image : Image      # active (clicked) image
    state    : bool       # whether is clicked or not
    pos      : (int, int)

proc setProperties (db: var DecorButton, pos: (int, int))

proc newDecorButton* (pos: (int, int), uim: Image, aim: Image): DecorButton =
    if uim.res != aim.res: # checks if both state images are equal
      raise newException(Exception, "DecorButton images differ in size! " & $uim.res & "<>" & $aim.res)
    result.un_image = uim
    result.ac_image = aim
    result.state    = false
    result.pos      = pos
    result.setProperties(pos)

proc drawDecorButton* (w: var Window, db: DecorButton, cond: bool = true) =
    if db.state:
      drawImage(w, db.ac_image, cond=cond)
    else:
      drawImage(w, db.un_image, cond=cond)

proc drawDecorButton* (w: var Window, db: var DecorButton, pos: (int, int), cond: bool = true) =
    db.setProperties(pos)
    if db.state:
      drawImage(w, db.ac_image, pos, cond)
    else:
      drawImage(w, db.un_image, pos, cond)

#[ Returning 'self', it allows for chained initialisation:
      newDecorButton(...).setListener(...)

   However, this is usually not recommended, as initialisation every loop is
   risky and also performance-heavy. Instead, you'd prefer to set listener
   in main loop, while keeping initialisation outside of it:
      var button = newDecorButton(...)

      while window.tick():
         discard button.setListener(...)

   Current returning implementation is experimental and may change in the future ]#
proc setListener* (db: var DecorButton, w: Window, button: MouseButton = LEFT): DecorButton =
    if getMousePressed(w, button):
      if collide(db.un_image, getMousePos(w)):
        db.state = true
      else:
        db.state = false
    else:
      db.state = false
    return db

proc isClicked* (w: Window, db: DecorButton, button: MouseButton = LEFT): bool =
    if getMousePressed(w, button):
      if collide(db.un_image, getMousePos(w)):
        return true
    return false

# bundled isClicked and setListener, so it doesn't double tasks
proc isClickedListener* (w: Window, db: var DecorButton, button: MouseButton = LEFT): bool =
    if getMousePressed(w, button):
      if collide(db.un_image, getMousePos(w)):
        db.state = true
      else:
        db.state = false
    else:
      db.state = false
    return db.state

# helper
proc setProperties (db: var DecorButton, pos: (int, int)) =
    db.un_image.pos = pos
    db.ac_image.pos = pos