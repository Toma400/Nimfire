import nimfire/colors
import nimfire/utils # use it if you want to use % values instead of raw pixels
import nimfire/draw # draw let you use drawing functions
import nimfire

# initialises Window object
var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)

while w.tick():
  w.drawRect((150, 150), (150, 150), BLACK)   # drawRect let you create rectangle shape (takes 'pos', 'size' and 'colour' args)

  # you can also use nimfire/utils to use % values instead of raw pixels:
  w.drawRect(p(w, 50, 50), pax(w, 30, 30), BLACK) # 'p' give you raw % values, while 'pax' and 'pay' let you adjust it to X or Y
                                                  #   : using 'pax' in this case let you draw square shape using (X:30, Y:30ofX)
                                                  #     instead of trying to calculate Y value by yourself

  w.update()

w.finish() # finish program