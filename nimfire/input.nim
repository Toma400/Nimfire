from nglfw/core import getKey
from types import Window
import std/tables

type
  Key* = enum # look at nglfw/core for references of numbers
    SPACE = 32
    A = 65
    B = 66
    C = 67
    D = 68
    E = 69
    F = 70
    G = 71
    H = 72
    I = 73
    J = 74
    K = 75
    L = 76
    M = 77
    N = 78
    O = 79
    P = 80
    Q = 81
    R = 82
    S = 83
    T = 84
    U = 85
    V = 86
    W = 87
    X = 88
    Y = 89
    Z = 90
    ESCAPE = 256
    RIGHT  = 262
    LEFT   = 263
    DOWN   = 264
    UP     = 265

const
  keys = {"a":      A,
          "b":      B,
          "c":      C,
          "d":      D,
          "e":      E,
          "f":      F,
          "g":      G,
          "h":      H,
          "i":      I,
          "j":      J,
          "k":      K,
          "l":      L,
          "m":      M,
          "n":      N,
          "o":      O,
          "p":      P,
          "q":      Q,
          "r":      R,
          "s":      S,
          "t":      T,
          "u":      U,
          "v":      V,
          "x":      X,
          "y":      Y,
          "z":      Z,
          "up":     UP,
          "down":   DOWN,
          "left":   LEFT,
          "right":  RIGHT,
          "space":  SPACE,
          "escape": ESCAPE}.toTable

#[ Returns whether specific key is pressed or not. Takes Key enum or string representation ]#
proc getKeyPressed* (w: Window, k: Key): bool =
    return getKey(w.scr.win.ct, k.cint) == 1         # uses nglfw, ref path: Nimfire.Window > glFB.Screen > glFB.Window > glfw.Window
proc getKeyPressed* (w: Window, k: string): bool =
    return getKey(w.scr.win.ct, keys[k].cint) == 1   # uses nglfw, ref path: Nimfire.Window > glFB.Screen > glFB.Window > glfw.Window

#[ Returns whether any of keys listed is pressed or not. Takes Key enum or string representation ]#
proc anyKeysPressed* (w: Window, k: varargs[Key]): bool =
    for key in k:
      if getKeyPressed(w, key) == true: return true
    return false
proc anyKeysPressed* (w: Window, k: varargs[string]): bool =
    for key in k:
      if getKeyPressed(w, key) == true: return true
    return false

#[ Returns whether all of keys listed is pressed or not. Takes Key enum or string representation ]#
proc allKeysPressed* (w: Window, k: varargs[Key]): bool =
    for key in k:
      if getKeyPressed(w, key) == false: return false
    return k.len > 0
proc allKeysPressed* (w: Window, k: varargs[string]): bool =
    for key in k:
      if getKeyPressed(w, key) == false: return false
    return k.len > 0