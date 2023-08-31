from types import Window, Axis

#[ Gives you % pixel value of specific context
- perc    : int | required >> % value that we want to get
- context : int | required >> size that we compare % to ]#
proc getPxPerc* (perc: int, context: int): int =
    return (perc.float * (context.float / 100)).int

#[ Let you use % values instead of raw pixels, for given window axis ]#
proc getPxPerc* (w: var Window, perc: int, axis: Axis): int =
    case axis:
      of Axis.X: return getPxPerc(perc, w.res[0])
      of Axis.Y: return getPxPerc(perc, w.res[1])

#[ Let you use % values instead of raw pixels ]#
proc p* (w: var Window, x, y: int): (int, int) =
    return (w.getPxPerc(x, Axis.X), w.getPxPerc(y, Axis.Y))
#[ Tuple variant of p* above ]#
proc p* (w: var Window, xy: (int, int)): (int, int) =
    return (w.getPxPerc(xy[0], Axis.X), w.getPxPerc(xy[1], Axis.Y))

# pc, but adjusted to X axes (10% of X becomes 10% of Y); helps drawing square-like objects
#   - may overflow, since Y value is not aligned with screen
#   - if resizable window is on, needs to be called again to adjust size
proc pax* (w: var Window, x, y: int): (int, int) =
    return (w.getPxPerc(x, Axis.X), w.getPxPerc(y, Axis.X))

# pc, but adjusted to Y axes (10% of Y becomes 10% of X); helps drawing square-like objects
#   - may overflow, since X value is not aligned with screen
#   - if resizable window is on, needs to be called again to adjust size
proc pay* (w: var Window, x, y: int): (int, int) =
    return (w.getPxPerc(x, Axis.Y), w.getPxPerc(y, Axis.Y))