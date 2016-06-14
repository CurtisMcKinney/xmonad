import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders

main :: IO ()
main = xmobar xconfig >>= xmonad

xconfig = defaultConfig
        { terminal           = "gnome-terminal"
        , modMask            = mod4Mask
        , borderWidth        = 1
        , focusedBorderColor = "#005070"
        , normalBorderColor  = "#000000"
        , manageHook         = myManageHook <+> manageDocks <+> manageHook defaultConfig
        , layoutHook         = myLayout
        , startupHook        = myStartupHook
        , focusFollowsMouse  = False
        }

myManageHook = composeAll [ className =? "Firefox" --> doShift "2" ]

myLayout = avoidStruts (tallLayout ||| Mirror tallLayout) ||| noBorders (fullscreenFull Full)
    where
        tallLayout = Tall 1 (3/100) (1/2)

myStartupHook :: X ()
myStartupHook = do
    spawn "feh --bg-fill /home/casiosk1/Pictures/Samus_vs_Kraid_in_Super_Metroid.jpg"
    spawn "firefox"
    startupHook defaultConfig

-- ~/.xinitrc
-- xmodmap ~/.Xmodmap

-- ~/.Xmodmap
-- remove Lock = Caps_Lock
-- keysym Caps_Lock = Control_L
-- add Control = Control_L
-- pointer = 1 2 3 5 4 7 6 8 9 10 11 12
