from chroma import ColorRGBX
import ../colors
import ../draw

type
  ProgressBar = object
    pos          : (int, int)
    size         : (int, int)
    progress     : int
    bg_col       : ColorRGBX
    progress_col : ColorRGBX
    bg_rect      : Rect

proc newProgressBar(pos: (int, int),
                    size: (int, int),
                    progress: int = 100,
                    bg_col: ColorRGBX = WHITE,
                    progress_col: ColorRGBX = PINE_GREEN): ProgressBar =
    result.pos  = pos
    result.size = size
    result.progress = progress # can be overriden later (in drawing)
    result.bg_col = bg_col
    result.progress_col = progress_col
    result.bg_rect = newRect(pos, size, bg_col)

proc drawProgressBar(pb: ProgressBar,
                     pos: (int, int) = pb.pos,
                     progress: int = pb.progress,
                     cond: bool = true) =
    drawRect(pb.bg_rect, cond, pb.pos)
    drawRect(pos, (pb.size*(progress/100), pb.size[1]), pb.progress_col, cond)