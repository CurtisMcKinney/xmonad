import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.FadeInactive
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import Graphics.X11.ExtraTypes.XF86
import XMonad.Util.EZConfig

main :: IO ()
-- main = xmobar xconfig >>= xmonad
main = xmonad xconfig

xconfig = defaultConfig
        { terminal           = "termite"
        , modMask            = mod4Mask
        , borderWidth        = 2
        , focusedBorderColor = "#707070"
        , normalBorderColor  = "#505050"
        , manageHook         = myManageHook <+> manageDocks <+> manageHook defaultConfig
        , layoutHook         = myLayout
        , startupHook        = myStartupHook
        , logHook            = myLogHook
        , focusFollowsMouse  = False
        } `additionalKeysP` myKeys

myManageHook :: ManageHook
myManageHook = composeAll [ className =? "Firefox" --> doShift "1" ]

myLayout = smartSpacing 12 $ avoidStruts (tallLayout ||| Mirror tallLayout) ||| noBorders (fullscreenFull Full)
    where
        tallLayout = Tall 1 (3/100) (1/2)

myStartupHook :: X ()
myStartupHook = do
    spawn "feh --bg-fill /home/casiosk1/Pictures/metroid_desaturate.jpg" -- Metroid start screen background
    spawn "pgrep firefox || firefox"
    spawn "pgrep xcompmgr || xcompmgr -c -C -t-5 -l-5 -r4.2 -o.1"
    startupHook defaultConfig

myLogHook :: X ()
myLogHook = fadeInactiveLogHook 0.5

myKeys :: [(String, X ())]
myKeys = [ ("<XF86MonBrightnessUp>",   spawn "xbacklight +20")
         , ("<XF86MonBrightnessDown>", spawn "xbacklight -20")
         , ("<XF86AudioRaiseVolume>",  spawn "pactl set-sink-volume 0 +10%")
         , ("<XF86AudioLowerVolume>",  spawn "pactl set-sink-volume 0 -10%")
         , ("<XF86AudioMute>",         spawn "pactl set-sink-mute 0 toggle")
         ]

-- ~/.xinitrc
-- xmodmap ~/.Xmodmap

-- ~/.Xmodmap
-- remove Lock = Caps_Lock
-- keysym Caps_Lock = Control_L
-- add Control = Control_L
-- pointer = 1 2 3 5 4 7 6 8 9 10 11 12
--

-- ~/.config/termite/config
--[options]
--font = Hermit Medium 10
--
--[colors]
--background = rgba(0, 0, 0, 0.7)
--cursor     = #B03030
