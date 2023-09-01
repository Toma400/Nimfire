import nimfire/colors
import nimfire/utils # use it if you want to use % values instead of raw pixels
import nimfire/draw # draw let you use drawing functions
import nimfire

# initialises Window object
var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)
var counter = 0

while w.tick():
  w.drawRect((150, 150), (150, 150), BLACK)   # drawRect let you create rectangle shape (takes 'pos', 'size' and 'colour' args)

  # you can also use nimfire/utils to use % values instead of raw pixels:
  w.drawRect(p(w, 50, 50), pax(w, 30, 30), BLACK) # 'p' give you raw % values, while 'pax' and 'pay' let you adjust it to X or Y
                                                  #   : using 'pax' in this case let you draw square shape using (X:30, Y:30ofX)
                                                  #     instead of trying to calculate Y value by yourself

  counter += 1
  w.drawRect((5, 5), (15, 15), BLACK, counter < 1000) # you can also declare condition on which drawRect renders the image
                                                      # (by default it is always true, as you can still manage it from outside)
                                                      #  : in this example, rectangle will disappear once 'counter' reaches 1000

  # drawRect can also take Rect object as argument, which gives you better control over drawn rectangles
  #  : look at 'rect_management' file for further reference

  w.update()

w.finish() # finish program