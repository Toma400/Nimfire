from chroma import ColorRGBX
import ../colors
import ../draw
import ../types

type
  ProgressBar = object
    pos          : (int, int)
    size         : (int, int)
    progress     : int
    bg_col       : ColorRGBX
    progress_col : ColorRGBX
    bg_rect      : Rect
  # Button = object # should have special drawing system that draws some "pseudoshade" on edges
  #   pos       : (int, int)
  #   size      : (int, int)
  #   border    : uint
  #   text      : string
  #   front_col : ColorRGBX
  #   bg_col    : ColorRGBX
  #   rect      : Rect
  #   bg_rect   : Rect
  # # making \____/
  # # this    |  |
  # # shape  /----\
  # # of button is doable by simply iterating over [0,0] of Rect1 to [0,0] of Rect2, and
  # # the same for each corner - and then either drawing those iterations like brush, or!
  # # changing Rect1 (bg_rect) matrix in there - making this more performant, as only one
  # # iteration is needed and then all drawing takes place normally on two matrixes
  # # (instead of two matrixes + four iterations)

proc newProgressBar* (pos          : (int, int),
                      size         : (int, int),
                      progress     : int        = 100,
                      bg_col       : ColorRGBX  = WHITE,
                      progress_col : ColorRGBX  = PINE_GREEN): ProgressBar =
    result.pos  = pos
    result.size = size
    result.progress = progress # can be overriden later (in drawing)
    result.bg_col = bg_col
    result.progress_col = progress_col
    result.bg_rect = newRect(pos, size, bg_col)

#[ Drawing progress bar. Progress value should be between 0 and 100, else it will get outside bar frames
   This is set intentionally for now, as it may be useful for some, and it lets user gain more control  ]#
proc drawProgressBar* (w        : var Window,
                       pb       : var ProgressBar,
                       pos      : (int, int) = pb.pos,
                       progress : int        = pb.progress,
                       cond     : bool       = true) =
    drawRect(w, pb.bg_rect, cond, pb.pos)
    drawRect(w, pos, ((pb.size[0].float*(progress/100)).int, pb.size[1]), pb.progress_col, cond)