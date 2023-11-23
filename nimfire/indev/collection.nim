import ../../nimfire/image
import ../../nimfire/types
import std/sequtils
import std/tables
import std/sets

type
  Collection = object
    elems:   seq[Image]
    fatrix*: HashSet[(int, int)]

proc newCollection* (elems: varargs[Image]): Collection =
    result.elems = toSeq(elems)
    for elem in result.elems:
      for rel_pos in keys(elem.fatrix):
        result.fatrix.incl((rel_pos[0] + elem.pos[0],
                            rel_pos[1] + elem.pos[1]))

proc drawCollection* (w: var Window, col: Collection) =
    for elem in col.elems:
      drawImage(w, elem)

proc collide* (col: Collection, pos: (int, int)): bool =
    if col.fatrix.contains(pos):
      return true
    return false

proc add* (col: var Collection, i: Image) =
    col.elems.add(i)
    for rel_pos in keys(i.fatrix):
      col.fatrix.incl((rel_pos[0] + i.pos[0],
                       rel_pos[1] + i.pos[1]))

proc remove* (col: var Collection, index: int) =
    if col.elems.len() > index:
      col.elems.delete(index)
      # rebuilding matrix entirely because there can be some pixel positions used by multiple Image objects at once
      clear(col.fatrix)
      for elem in col.elems:
        for rel_pos in keys(elem.fatrix):
          col.fatrix.incl((rel_pos[0] + elem.pos[0],
                           rel_pos[1] + elem.pos[1]))
    else:
      raise newException(Exception, "Tried to reach index " & $index & " while collection has " & $len(col.elems) & " elements.")