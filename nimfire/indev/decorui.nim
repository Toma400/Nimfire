import ../image
import ../input
import ../types

type
  DecorButtonState = enum
    DEFAULT
    HOVERED
    CLICKED

  DecorButton = object
    un_image : Image            # unclicked
    ac_image : Image            # activated (clicked) image
    hv_image : Image            # hovered image
    state    : DecorButtonState # state of DecorButton
    pos      : (int, int)

proc newDecorButton* (pos: (int, int), uim: Image, aim: Image = uim, him: Image = uim): DecorButton =
    if (uim.res != aim.res) or (uim.res != him.res): # checks if both state images are equal
      raise newException(Exception, "DecorButton images differ in size! " & $uim.res & " <> " & $aim.res)
    result.un_image = uim
    result.ac_image = aim
    result.hv_image = him
    result.state    = DEFAULT
    block setPos:
      result.un_image.pos = pos
      result.ac_image.pos = pos
      result.hv_image.pos = pos

proc drawDecorButton* (w: var Window, db: var DecorButton, cond: bool = true, button: MouseButton = LEFT) =
    if not collide(db.un_image, getMousePos(w)): db.state = DEFAULT
    else:
      if not getMousePressed(w, button):         db.state = HOVERED
      else:                                      db.state = CLICKED

    case db.state:
      of DEFAULT: drawImage(w, db.un_image, cond=cond)
      of HOVERED: drawImage(w, db.hv_image, cond=cond)
      of CLICKED: drawImage(w, db.ac_image, cond=cond)

proc drawDecorButton* (w: var Window, db: var DecorButton, pos: (int, int), cond: bool = true, button: MouseButton = LEFT) =
    db.pos          = pos
    db.un_image.pos = pos
    db.ac_image.pos = pos
    db.hv_image.pos = pos
    drawDecorButton(w, db, cond, button)

proc setListener* (db: var DecorButton, w: Window, button: MouseButton = LEFT): DecorButton {.deprecated: "Function -setListener- was deprecated in 0.1.4 and will be removed in 0.1.5 as it is now redundant. Please adjust your code".} =
    if collide(db.un_image, getMousePos(w)):
      if getMousePressed(w, button): db.state = CLICKED
      else:                          db.state = HOVERED
    else:                            db.state = DEFAULT
    return db

proc isHovered* (w: Window, db: DecorButton): bool =
    return db.state == HOVERED

proc isClicked* (w: Window, db: DecorButton): bool =
    return db.state == CLICKED

proc isClicked* (w: Window, db: DecorButton, button: MouseButton): bool =
    if not collide(db.un_image, getMousePos(w)):
      if getMousePressed(w, button):
        return true
    return false

# bundled isClicked and setListener, so it doesn't double tasks
proc isClickedListener* (w: Window, db: var DecorButton, button: MouseButton = LEFT): DecorButtonState {.deprecated: "Function -isClickedListener- was deprecated in 0.1.4 and will be removed in 0.1.5 as it is now redundant. Please adjust your code".} =
    if collide(db.un_image, getMousePos(w)):
      if getMousePressed(w, button): db.state = CLICKED
      else:                          db.state = HOVERED
    else:                            db.state = DEFAULT
    return db.state