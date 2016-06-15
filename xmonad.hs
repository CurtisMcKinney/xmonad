import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

main :: IO ()
-- main = xmobar xconfig >>= xmonad
main = xmonad xconfig

xconfig = defaultConfig
        { terminal           = "xfce4-terminal"
        , modMask            = mod4Mask
        , borderWidth        = 2
        -- , focusedBorderColor = "#602060"
        , focusedBorderColor = "#704070"
        , normalBorderColor  = "#505050"
        , manageHook         = myManageHook <+> manageDocks <+> manageHook defaultConfig
        , layoutHook         = myLayout
        , startupHook        = myStartupHook
        , logHook            = myLogHook
        , focusFollowsMouse  = False
        }

myManageHook = composeAll [ className =? "Firefox" --> doShift "1" ]

myLayout = smartSpacing 12 $ avoidStruts (tallLayout ||| Mirror tallLayout) ||| noBorders (fullscreenFull Full)
    where
        tallLayout = Tall 1 (3/100) (1/2)

myStartupHook :: X ()
myStartupHook = do
    -- spawn "feh --bg-fill /home/casiosk1/Pictures/Samus_vs_Kraid_in_Super_Metroid.jpg"
    -- spawn "feh --bg-fill /home/casiosk1/Pictures/maxresdefault.jpg" -- Metroid start screen background
    spawn "feh --bg-fill /home/casiosk1/Pictures/metroid_desaturate.jpg" -- Metroid start screen background
    spawn "pgrep firefox || firefox"
    spawn "pgrep xcompmgr || xcompmgr -c -C -t-5 -l-5 -r4.2 -o.1"
    startupHook defaultConfig

myLogHook :: X ()
myLogHook = fadeInactiveLogHook 0.8

-- ~/.xinitrc
-- xmodmap ~/.Xmodmap

-- ~/.Xmodmap
-- remove Lock = Caps_Lock
-- keysym Caps_Lock = Control_L
-- add Control = Control_L
-- pointer = 1 2 3 5 4 7 6 8 9 10 11 12
--

--term font: monofur Bold 11
--term font: Hermit Medium 10
--term font: peep Medium 10 or maybe Bold?
