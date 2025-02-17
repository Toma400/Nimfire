from pixie/fileformats/png import convertToImage, decodePng, encodePng
from pixie import Font, readFont, fillText
from chroma import ColorRGBX
import ../colors
import ../types
import ../image
import ../draw

type
  Text* = object
    bg_rect* : Rect
    text*    : string
    font*    : Font
    size*    : int
    pixmg*   : Image

proc setText (r: Rect, font: Font, text: string, size: int): Image

#[ Text constructors. Overload let you either set your own font or pick from one of defaults ]#
#[ Rect-deriving ]#
proc newText* (r: Rect, text: string, size: int = 15, font_path: string): Text =
    result.bg_rect = r
    result.text  = text
    result.font  = readFont(font_path)
    result.size  = size
    result.pixmg = setText(r, result.font, text, size)

#[ Rect-creating ]#
proc newText* (text: string, size: int = 15, font: string, pos: (int, int), bsize: (int, int), colour: ColorRGBX = TRANSPARENT): Text =
    result.bg_rect = newRect(pos, bsize, colour)
    result.text  = text
    result.font  = readFont(font)
    result.size  = size
    result.pixmg = setText(result.bg_rect, result.font, text, size)

proc drawText* (w: var Window, t: Text, pos: (int, int) = t.bg_rect.pos, cond: bool = true) =
    if cond:
      drawImage(w, t.pixmg, pos)

# edits the text after initial steps
proc setText* (t: var Text, text: string = t.text) =
    t.text  = text
    t.pixmg = setText(t.bg_rect, t.font, t.text, t.size)

# colours the text after initial steps (single colour)
proc setSingleColor* (t: var Text, rgba: (uint8, uint8, uint8, uint8)) =
    t.font.paints = @[rgba]
    t.pixmg       = setText(t.bg_rect, t.font, t.text, t.size)

proc setSingleColor* (t: var Text, hex: string, transparency: uint8 = 255) =
    setSingleColor(t, toTuple(toRGBX(hex, transparency)))

proc setSingleColor* (t: var Text, rgbx: ColorRGBX) =
    setSingleColor(t, toTuple(rgbx))

#[ Helper proc: makes once-performed Pixie operation that binds text to Rect ]#
proc setText (r: Rect, font: Font, text: string, size: int): Image =
    let img   = r.toImage()
    let pixmg = convertToImage(img.png)
    let ffont = font
    ffont.size = float32(size) # sets size into pixie.Font type
    pixmg.fillText(ffont, text)
    var pixpng = decodePng(encodePng(pixmg)) # pixie.Png file that can be used later for nimfire.Image creation
    block Result:
      result.pos = r.pos
      result.png = pixpng
      result.res = (result.png.width, result.png.height)
      result.matrix = createMatrix(result.res, result.png.data)
      result.fatrix = filterMatrix(result.matrix)