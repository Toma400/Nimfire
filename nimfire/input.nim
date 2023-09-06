from nglfw/core import getKey, getMouseButton, getCursorPos
from ../nimfire import getRes
from types import Window
import std/tables

type
  Key* = enum # look at nglfw/core for references of numbers
    SPACE  = 32
    COMMA  = 44 # ','
    MINUS  = 45 # '-'
    DOT    = 46 # '.'
    PERIOD = 46 # '.'
    SLASH  = 47 # '/'
    N0 = 48 # 0-9 numerical keys
    N1 = 49
    N2 = 50
    N3 = 51
    N4 = 52
    N5 = 53
    N6 = 54
    N7 = 55
    N8 = 56
    N9 = 57
    SEMICOLON = 60 # ';'
    PLUS      = 61 # '+' (plus button, not plus character)
    EQUAL     = 61 # '=' (equal button, not equal character)
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
    L_BRACKET    = 91 # '['
    BACKSLASH    = 92 # '\'
    R_BRACKET    = 93 # ']'
    TILDE        = 96 # '`' (tilde button, not tilde character)
    ESCAPE       = 256
    ENTER        = 257
    TAB          = 258
    BACKSPACE    = 259
    INSERT       = 260
    DELETE       = 261
    RIGHT        = 262 # arrow keys (<, ^, v, >)
    LEFT         = 263
    DOWN         = 264
    UP           = 265
    HOME         = 268
    END          = 269
    CAPS_LOCK    = 280
    PRINT_SCREEN = 283
    F1     = 290
    F2     = 291
    F3     = 292
    F4     = 293
    F5     = 294
    F6     = 295
    F7     = 296
    F8     = 297
    F9     = 298
    F10    = 299
    F11    = 300
    F12    = 301
    F13    = 302
    F14    = 303
    F15    = 304
    F16    = 305
    F17    = 306
    F18    = 307
    F19    = 308
    F20    = 309
    F21    = 310
    F22    = 311
    F23    = 312
    F24    = 313
    F25    = 314
    L_SHIFT = 340
    L_CTRL  = 341
    L_ALT   = 342
    R_SHIFT = 344
    R_CTRL  = 345
    R_ALT   = 346
  MouseButton* = enum
    LEFT   = 1
    RIGHT  = 2
    MIDDLE = 3
    UNN_4  = 4 # nglfw introduces more buttons, so they can be reached
    UNN_5  = 5
    UNN_6  = 6
    UNN_7  = 7
    UNN_8  = 8

const
  keys* = {"a":       A,
           "b":       B,
           "c":       C,
           "d":       D,
           "e":       E,
           "f":       F,
           "g":       G,
           "h":       H,
           "i":       I,
           "j":       J,
           "k":       K,
           "l":       L,
           "m":       M,
           "n":       N,
           "o":       O,
           "p":       P,
           "q":       Q,
           "r":       R,
           "s":       S,
           "t":       T,
           "u":       U,
           "v":       V,
           "x":       X,
           "y":       Y,
           "z":       Z,
           "up":      UP,
           "down":    DOWN,
           "left":    LEFT,
           "right":   RIGHT,
           "space":   SPACE,
           "enter":   ENTER,
           "lshift":  L_SHIFT,
           "rshift":  R_SHIFT,
           "lctrl":   L_CTRL,
           "rctrl":   R_CTRL,
           "lalt":    L_ALT,
           "ralt":    R_ALT,
           "l_shift": L_SHIFT,
           "r_shift": R_SHIFT,
           "l_ctrl":  L_CTRL,
           "r_ctrl":  R_CTRL,
           "l_alt":   L_ALT,
           "r_alt":   R_ALT,
           "tab":     TAB,
           "0":       N0,
           "1":       N1,
           "2":       N2,
           "3":       N3,
           "4":       N4,
           "5":       N5,
           "6":       N6,
           "7":       N7,
           "8":       N8,
           "9":       N9,
           "zero":    N0, # text variants
           "one":     N1,
           "two":     N2,
           "three":   N3,
           "four":    N4,
           "five":    N5,
           "six":     N6,
           "seven":   N7,
           "eight":   N8,
           "nine":    N9,
           "f1":      F1,
           "f2":      F2,
           "f3":      F3,
           "f4":      F4,
           "f5":      F5,
           "f6":      F6,
           "f7":      F7,
           "f8":      F8,
           "f9":      F9,
           "f10":     F10,
           "f11":     F11,
           "f12":     F12,
           "f13":     F13,
           "f14":     F14,
           "f15":     F15,
           "f16":     F16,
           "f17":     F17,
           "f18":     F18,
           "f19":     F19,
           "f20":     F20,
           "f21":     F21,
           "f22":     F22,
           "f23":     F23,
           "f24":     F24,
           "f25":     F25,
           "plus":    PLUS,  # '+' (same as '=')
           "minus":   MINUS, # '-'
           "equal":   EQUAL, # '=' (same as '+')
           "lbracket":  L_BRACKET, # '['
           "rbracket":  R_BRACKET, # ']'
           "l_bracket": L_BRACKET, # '['
           "r_bracket": R_BRACKET, # ']'
           "slash":     SLASH,     # '/'
           "backslash": BACKSLASH, # '\'
           "tilde":        TILDE,     # '`'
           "grave":        TILDE,     # '`'
           "semicolon":    SEMICOLON, # ';'
           "dot":          DOT,       # '.'
           "period":       PERIOD,    # '.'
           "comma":        COMMA,     # ','
           "insert":       INSERT,
           "backspace":    BACKSPACE,
           "delete":       DELETE,
           "home":         HOME,
           "end":          END,
           "caps_lock":    CAPS_LOCK,
           "print_screen": PRINT_SCREEN,
           "escape":  ESCAPE}.toOrderedTable
  mouse* = {"left":   MOUSEBUTTON.LEFT,
            "right":  MOUSEBUTTON.RIGHT,
            "middle": MOUSEBUTTON.MIDDLE}.toOrderedTable

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

#[ Returns whether specific button was pressed ]#
proc getMousePressed* (w: Window, button: MouseButton = LEFT): bool =
    return getMouseButton(w.scr.win.ct, button.cint - 1) == 1
proc getMousePressed* (w: Window, button: string): bool =
    return getMouseButton(w.scr.win.ct, mouse[button].cint - 1) == 1

#[ Returns position of a mouse. Uses (-1, -1) as special coordinates of bug ]#
proc getMousePos* (w: var Window): (int, int) =
    var cx: cdouble
    var cy: cdouble
    getCursorPos(w.scr.win.ct, addr cx, addr cy)
    return (int(cx), int(cy))