---------------------------------------------------------------------------
--                                                                       --
--     _|      _|  _|      _|                                      _|    --
--       _|  _|    _|_|  _|_|    _|_|    _|_|_|      _|_|_|    _|_|_|    --
--         _|      _|  _|  _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--       _|  _|    _|      _|  _|    _|  _|    _|  _|    _|  _|    _|    --
--     _|      _|  _|      _|    _|_|    _|    _|    _|_|_|    _|_|_|    --
--                                                                       --
---------------------------------------------------------------------------
{-# LANGUAGE PatternSynonyms #-}

import XMonad
import XMonad.Hooks.DynamicLog (shorten, dynamicLogWithPP)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (docksEventHook, docksStartupHook, manageDocks, docks)
import XMonad.Hooks.Minimize (minimizeEventHook)
import XMonad.Hooks.Place (smart, placeHook)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.UrgencyHook (UrgencyHook(..), withUrgencyHook)
import XMonad.Util.EZConfig (additionalKeysP, additionalKeys, removeKeys)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Actions.SpawnOn (spawnOn, manageSpawn)
import XMonad.Layout.WindowArranger (pattern DecreaseRight, pattern IncreaseUp, windowArrange)
import XMonad.Util.Run(spawnPipe, safeSpawn)
import System.Environment (setEnv)
import System.Info (os)
import XMonad.Layout.IndependentScreens (countScreens)
import XMonad.Actions.DynamicProjects (dynamicProjects)
import XMonad.Util.NamedActions (addDescrKeys')
import XMonad.StackSet (findTag, view)
import XMonad.Util.NamedWindows (getName)

import Local.Colors (myFocusBorderColor, myColor, myBorderColor)
import Local.KeyBindings (superKeyMask, keybinds, searchPromptKeybindings, myRemoveKeys, showKeyBindings)
import Local.Workspaces (myWorkspaces, projects)
import Local.MouseBinding (myMouseBindings)
import Local.ManagedHook (myManageHook, myManageHook')
import Local.Layouts (myLayouts)
import Local.PolybarLogHook (eventLogHookForPolybar)
import Local.DzenLogHook (dzenLogHook)
import XMonad.Hooks.WindowSwallowing ( swallowEventHook )

-- sudo emerge --update --newuse media-fonts/terminus-font
-- xset +fp /usr/share/fonts/terminus
myFont :: String
-- myFont = "terminus"
-- myFont = "-*-terminus-medium-r-*-*-18-*-*-*-*-*-*-*"
myFont = "-*-terminus-*-r-normal-*-18-*-*-*-*-*-*-*"
-- myFont = "-*-terminus-medium-l-*-*-18-*-*-*-*-*-*-*"
-- myFont = "-*-terminus-*-*-*-*-14-*-*-*-*-*-*-*"
-- myFont="-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"

-- TODO fix the screen width
togglevga :: IO String
togglevga = do { screencount <- countScreens
    ; if screencount > 1
       then do
      let screenWidth = "2160"
      -- spawn "xrandr --output LVDS-0 --off --output HDMI-0 --auto"
      return screenWidth
       else do
      let screenWidth = "683"
      -- spawn "xrandr --output LVDS-0 --auto"
      return screenWidth
    ;}


-- 1925 is split of my 4k monitor
topLeftBar :: String
topLeftBar = "dzen2 -title-name top-left -p -w 1925 -ta l " ++ " -fg '" ++ myColor "foreground" ++ "' -bg '" ++ myColor "background" ++ "' -fn " ++ myFont

topRightDzen :: String
topRightDzen = "dzen2 -dock -title-name top-right -p -x 1925 -ta r " ++ " -fg '" ++ myColor "foreground" ++ "' -bg '" ++ "#320C2D" ++ "' -fn " ++ myFont

myTopRight :: String
myTopRight = "conky -c ~/.config/conky/xmonad-bar-top-right  | " ++ topRightDzen

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myHandleEventHook = swallowEventHook (className =? "Alacritty" <||> className =? "st" <||> className =? "kitty") (return True)

main :: IO ()
main = do
  screenWidth <- togglevga
  -- for polybar
  -- safeSpawn "mkfifo" ["/tmp/.xmonad-info"]

  dzenLeftBar <- spawnPipe topLeftBar
  conkyTopRight <- spawnPipe myTopRight

  xmonad
    $ withUrgencyHook LibNotifyUrgencyHook
    -- $ withUrgencyHook NoUrgencyHook
    $ dynamicProjects projects
    -- $ docks
-- bh changed on 7/24/2022
    -- $ ewmh . docks
    $ ewmhFullscreen
    $ ewmh
    $ docks
    -- bh keybinding (M-F1) for showing all KeyBindings
    $ addDescrKeys' ((superKeyMask, xK_F1), showKeyBindings) keybinds
    $ myConfig { logHook =
      case os of
        "freebsd"   -> dynamicLogWithPP $ dzenLogHook dzenLeftBar
        "linux"   -> dynamicLogWithPP $ dzenLogHook dzenLeftBar
        _    -> eventLogHookForPolybar
    }
    `removeKeys` myRemoveKeys
    `additionalKeysP` searchPromptKeybindings
    `additionalKeys` []

myTerminal :: String
myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 1

------------------------------------------------------------------------
-- desktop notifications -- dunst package required
------------------------------------------------------------------------
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        -- Just idx <- fmap (findTag w) $ gets windowset
        Just idx <- findTag w <$> gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

myAddSpaces :: Int -> String -> String
myAddSpaces len str = sstr ++ replicate (len - length sstr) ' '
  where
    sstr = shorten len str


myStartupHook :: X ()
myStartupHook = do
    setWMName "LG3D"
    liftIO (setEnv "DESKTOP_SESSION" "xmonad")
    case os of
      "freebsd" -> spawnOnce "networkmgr"
      "linux"   -> spawnOnce "nm-applet"
      _    -> return ()
    -- spawnOnce "$HOME/.config/polybar/launch.sh xmonad"
    spawnOnce "flameshot" --dbus required
    spawnOnce "dunst"
    -- spawnOnce "picom"
    spawnOnce "picom --experimental-backends --backend glx --config /dev/null --xrender-sync-fence"
    -- spawnOnce "sxhkd -c ~/.config/sxhkd/sxhkdrc-xmonad"
    -- spawn "clipmenud" --should I run copyq or clipmenu
    spawnOnce "copyq"
    spawnOn (myWorkspaces !! 7) "slack -u"
    spawnOn (head myWorkspaces) "terminal"
    case os of
      "freebsd" -> return ()
      "linux"   -> spawnOnce "blueman-applet" --dbus required
      _    -> return ()
    case os of
      "freebsd" -> return ()
      "linux"   -> spawnOnce "pamac-tray"
      _    -> return ()
    spawnOnce "numlockx on"
    spawnOnce "emacs --daemon"
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    -- spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 108 --transparent true --tint 0x000000 --height 18 --alpha 0"
    spawnOnce "trayer --edge bottom --align right --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 200 --transparent true --tint 0x000000 --height 18 --alpha 0"
    spawnOnce "conky -c $HOME/.config/conky/xmonad-system-overview"
    -- spawnOnce "mpDris2" -- required for mpd
    spawnOnce "volumeicon"
    spawnOnce "streamdeck-start"
    spawnOnce "xscreensaver -no-splash"
    spawnOnce "feh --no-fehbg --bg-scale $HOME/.local/wallpaper/minnesota-vikings-dark.png"
    -- spawnOnce "killall redshift; sleep 4 ; redshift -l 48.024395:11.598893 &"
    windows $ view (head myWorkspaces)

myConfig = def
  { terminal = myTerminal
  , layoutHook = windowArrange myLayouts
  , mouseBindings = myMouseBindings
  , manageHook = placeHook(smart(0.5, 0.5))
      <+> manageDocks
      <+> manageSpawn
      <+> myManageHook
      <+> myManageHook'
      <+> manageHook def
  , handleEventHook = minimizeEventHook <+> myHandleEventHook
      -- <+> fullscreenEventHook -- may have negative impact to flameshot
      -- <+> ewmhFullscreen
  -- , logHook = eventLogHookForPolybar
  , startupHook = myStartupHook
  , focusFollowsMouse = False
  , clickJustFocuses = False
  , borderWidth = myBorderWidth
  , normalBorderColor = myBorderColor
  , focusedBorderColor = myFocusBorderColor
  , workspaces = myWorkspaces
  , modMask = superKeyMask
  -- >> updatePointer (0.25, 0.25) (0.25, 0.25)
  }
   -- `additionalKeysP`
   -- [
   -- ]
   -- `additionalKeys`
   -- [
   -- ]
