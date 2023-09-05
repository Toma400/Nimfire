import nimfire/colors
import nimfire

var w = initWindow((800, 600), "Dance or Die - Simple Game", resizable=true, bg_colour=PULLMAN_BROWN)

while w.tick():

    w.update(true)

w.finish()