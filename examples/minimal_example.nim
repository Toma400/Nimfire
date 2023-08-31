import nimfire/colors # import if you want to use colors
import nimfire

# initialises Window object
 # precise args names aren't needed as long as you don't skip any (we skipped 'resizable' before 'bg_colour')
var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)

while w.tick(): # Nimfire let you control the loop
  w.update()      # update needs to be called every tick

w.finish() # after everything, you will need to exit the program


# you can also use Nimfire aliases:
#[
   initWindow = ignite
   tick (w)   = isBurning (w)
   update (w) = addWood (w)
   finish (w) = extinguish (w)
]#