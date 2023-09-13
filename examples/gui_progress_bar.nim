#[ important note!
   while this example is made for tutorial reasons and is kept with other
   examples here, GUI use is currently experimental feature and should be
   treated as such - in upcoming releases its behaviour or locations will
   most likely change ]#
import nimfire/indev/simpleui # in later releases it will be nimfire/simpleui
import nimfire/colors
import nimfire

var w = initWindow((800, 600), "Nimfire", bg_colour=PURPLE)
# we create progress bar by passing position, size and (optionally) colours
# if no colours are passed, background is WHITE and progress bar is green by default
var bar = newProgressBar((5, 5), (500, 50), bg_col=CREAM, progress_col=PURPLE)
var loading = 0 # additionally, we can declare variable that will mark our progress
                 # this can be handled differently, but it's one of options possible

while w.tick():
  w.drawProgressBar(bar, progress=loading) # we bind loading variable to 'progress' argument
                                           # this let us update progress in drawing proc
                                           # however!
                                           # if you'd to update progress manually, like so:
                                           #     bar.progress = loading
                                           # it's also possible; draw argument is optional

  if loading < 100: # we need to set boundaries check because ProgressBar currently
    loading += 1    #  doesn't restrict you to go outside of 0 < x < 100 range
                    # this may have advantage of control, but also means you need to control
                    # those values to not overflow progress bar image
                    # (negative values do not overflow progress bar, though)

  w.update()

w.finish()