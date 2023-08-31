# https://www.quora.com/How-do-I-build-my-own-GUI-framework-from-scratch
type
  OS = enum
    Win   #[ Windows:    priority                     ]#
    Lin   #[ Linux:      not supported - planned      ]#
    Mac   #[ MacOS:      not supported - planned      ]#
    Sct   #[ SanctOS:    not supported - planned late ]#
    Srn   #[ SerenityOS: not supported - planned late ]#
    Unk   #[ Other OS:   not supported                ]#
  Nimfire = object
    sys: OS

#[ Returns OS running. Contains only supported ones ]#
proc sysHelper(): OS =
    case hostOS:
      of "windows": return Win
      else:         return Unk

#[ Used to initialise the app ]#
proc ignite* (): Nimfire =
    let ret = Nimfire(
        sys: sysHelper()
    )
    return

proc newWindow* (n: Nimfire) =
    discard

# Used to close the app
proc extinguish* (n: Nimfire) =
    discard

#[
   NIMFIRE (manager) -- app (singleton)
     \
      \__ Window -- screens (can be multiple if needed)
           \
            \__ Properties (bar, name, etc.)
             \_ Widgets (can be nested)

]#
