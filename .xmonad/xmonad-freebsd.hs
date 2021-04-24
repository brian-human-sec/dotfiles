{-# LANGUAGE RebindableSyntax #-}
import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Minimize
import XMonad.Hooks.Place
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Util.EZConfig
import XMonad.Util.NamedActions
import XMonad.Util.SpawnOnce
import XMonad.Layout.FixedColumn
import XMonad.Actions.SpawnOn
import XMonad.Layout.LimitWindows
import XMonad.Layout.Magnifier
import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.WindowArranger
import XMonad.Layout.Gaps
import XMonad.Actions.Submap
-- Prompt
import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch
import Control.Arrow (first)

import XMonad.Util.NamedScratchpad

import Graphics.X11.ExtraTypes
import XMonad.Util.Paste (sendKey)

import qualified XMonad.Actions.Search as S

import XMonad.Util.Run(spawnPipe, safeSpawn)

import qualified XMonad.Layout.BoringWindows as B
import Control.Monad (forM_, join, liftM2)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified Codec.Binary.UTF8.String as UTF8
import Prelude
import Data.Maybe
import XMonad.Actions.GroupNavigation
import XMonad.Hooks.RefocusLast

import System.Environment (setEnv, getEnv)

main :: IO ()
main = do
  safeSpawn "mkfifo" ["/tmp/.xmonad-info"]
  xmonad
    $ withUrgencyHook NoUrgencyHook
    $ ewmh
    -- $ myConfig { logHook = fadeInactiveLogHook 0.9 <+> dynamicLogWithPP polybarLogHook }
    $ myConfig { logHook = dynamicLogWithPP polybarLogHook }
    `removeKeys` myRemoveKeys
    `additionalKeysP` myKeys
    `additionalKeys` []

myTerminal :: String
myTerminal = "alacritty"
--myModMask      = mod4Mask
-- modMask = 115 -- Windows start button
-- modMask = xK_Meta_L

-- xmodmap - shows the key mapping
-- TODO: need to fix as the Win [M1] key is now useless
altKeyMask :: KeyMask
altKeyMask = mod1Mask

superKeyMask :: KeyMask
superKeyMask = mod4Mask

myFont :: String
myFont = "xft:Mononoki Nerd Font:bold:size=9:antialias=true:hinting=true"

myBorderWidth :: Dimension
myBorderWidth = 1

myBrowser :: String
myBrowser = "brave"

mySpacing :: Int
mySpacing = 5

-- Purple
myBorderColor :: String
myBorderColor = "#282828"

red :: String
red = "#fb4934"

myFocusBorderColor :: String
myFocusBorderColor = "#5b51c9"

-- dracula
-- myNormalBorderColor = "#BFBFBF"
-- myFocusedBorderColor = "#89DDFF"

myRemoveKeys = [
                 (superKeyMask .|. shiftMask, xK_space)
               , (superKeyMask, xK_q)
               , (superKeyMask, xK_e)
               , (superKeyMask, xK_p)
               , (superKeyMask, xK_x)
               , (controlMask, xK_p)
               , (superKeyMask .|. shiftMask, xK_q)
               , (superKeyMask .|. shiftMask, xK_c)
               -- , (superKeyMask, xK_space)
               ]

archwiki, ebay, news, reddit, urban :: S.SearchEngine
archwiki = S.searchEngine "archwiki" "https://wiki.archlinux.org/index.php?search="
ebay     = S.searchEngine "ebay" "https://www.ebay.com/sch/i.html?_nkw="
news     = S.searchEngine "news" "https://news.google.com/search?q="
reddit   = S.searchEngine "reddit" "https://www.reddit.com/search/?q="
urban    = S.searchEngine "urban" "https://www.urbandictionary.com/define.php?term="

searchList :: [(String, S.SearchEngine)]
searchList = [ ("a", archwiki)
    , ("d", S.duckduckgo)
    , ("e", ebay)
    , ("g", S.google)
    , ("h", S.hoogle)
    , ("i", S.images)
    , ("n", news)
    , ("r", reddit)
    , ("s", S.stackage)
    , ("t", S.thesaurus)
    , ("v", S.vocabulary)
    , ("b", S.wayback)
    , ("u", urban)
    , ("w", S.wikipedia)
    , ("y", S.youtube)
    , ("z", S.amazon)
  ]

myXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
myXPKeymap = M.fromList $
     map (first $ (,) controlMask)   -- control + <key>
     [ (xK_z, killBefore)            -- kill line backwards
     , (xK_k, killAfter)             -- kill line forwards
     , (xK_a, startOfLine)           -- move to the beginning of the line
     , (xK_e, endOfLine)             -- move to the end of the line
     , (xK_m, deleteString Next)     -- delete a character foward
     , (xK_b, moveCursor Prev)       -- move cursor forward
     , (xK_f, moveCursor Next)       -- move cursor backward
     , (xK_BackSpace, killWord Prev) -- kill the previous word
     , (xK_v, pasteString)           -- paste a string
     , (xK_g, quit)                  -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) superKeyMask)       -- meta key + <key>
     [ (xK_BackSpace, killWord Prev) -- kill the prev word
     , (xK_f, moveWord Next)         -- move a word forward
     , (xK_b, moveWord Prev)         -- move a word backward
     , (xK_d, killWord Next)         -- kill the next word
     , (xK_n, moveHistory W.focusUp')   -- move up thru history
     , (xK_p, moveHistory W.focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]

myXPConfig :: XPConfig
myXPConfig = def
      { font                = myFont
      , bgColor             = "#292d3e"
      , fgColor             = "#d0d0d0"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#535974"
      , promptBorderWidth   = 0
      , promptKeymap        = myXPKeymap
      , position            = Top
      , height              = 20
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate     = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }

myXPConfig' :: XPConfig
myXPConfig' = myXPConfig
      { autoComplete        = Nothing
      }

-- TODO: not sure what this code does right now
keyBindings conf = let m = modMask conf in
     M.fromList
    [((m .|. superKeyMask, k), windows $ f i) |
     (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
     (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myLayouts = renamed [CutWordsLeft 1] . avoidStruts . minimize . B.boringWindows $ perWS

-- layout per workspace
perWS = onWorkspace ws1 my3FT $
        onWorkspace ws2 myAll $
        onWorkspace ws3 myFTM $
        onWorkspace ws4 my3FT $
        onWorkspace ws5 myFTM $
        onWorkspace ws6 myFT myAll -- all layouts for all other workspaces

myFT  = myTileLayout ||| myFullLayout ||| commonLayout
myFTM = myTileLayout ||| myFullLayout ||| myMagn
my3FT = myTileLayout ||| myFullLayout ||| my3cmi
myAll = myTileLayout ||| myFullLayout ||| my3cmi ||| myMagn

myFullLayout = renamed [Replace "Full"]
    $ gaps [(U,5), (D,5)]
    $ noBorders Full
myTileLayout = renamed [Replace "Main"]
    $ Tall 1 (3/100) (1/2)
my3cmi = renamed [Replace "3Col"]
    $ ThreeColMid 1 (3/100) (1/2)
myMagn = renamed [Replace "Mag"]
    $ noBorders
    $ limitWindows 3
    $ magnifiercz' 1.4
    $ FixedColumn 1 20 80 10
commonLayout = renamed [Replace "Com"]
    $ avoidStruts
    $ gaps [(U,5), (D,5)]
    $ Tall 1 (5/100) (1/3)
myTiled = renamed [Replace "test1" ]
    $ Tall 1 (1/2)

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
    where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

ws1 = "1"
ws2 = "2"
ws3 = "3"
ws4 = "4"
ws5 = "5"
ws6 = "6"
ws7 = "7"
ws8 = "8"
ws9 = "9"
ws0 = "0"

myWorkspaces :: [String]
myWorkspaces = [ws1, ws2, ws3, ws4, ws5, ws6, ws7, ws8, ws9, ws0]
-- myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

-- clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
--     where i = fromJust $ M.lookup ws myWorkspaceIndices

-- runFlameshot :: String -> X ()
-- runFlameshot mode = do
--   ssDir <- io getCaptureDir
--   spawnCmd "flameshot" $ mode : ["-p", ssDir]

-- -- TODO this will steal focus from the current window (and puts it
-- -- in the root window?) ...need to fix
-- runAreaCapture :: X ()
-- runAreaCapture = runFlameshot "gui"

-- clipboardCopy :: X ()
-- clipboardCopy =
--   withFocused $ \w ->
--     b <- isTerminal w
--     if b
--     then (sendKey noModMask xF86XK_Copy)
--     else (sendKey controlMask xK_c)

-- clipboardPaste :: X ()
-- clipboardPaste =
--   withFocused $ \w ->
--       b <- isTerminal w
--       if b
--         then sendKey noModMask xF86XK_Paste
--         else sendKey controlMask xK_v

isTerminal :: Window -> X Bool
isTerminal = fmap (== "Alacritty") . runQuery className

myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList
    [
--     -- mod-button1, Set the window to floating mode and move by dragging
     ((modm, button1),
   \ w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster),
--     -- mod-button2, Raise the window to the top of the stack
     ((modm, button2), \ w -> focus w >> windows W.shiftMaster),
--     -- mod-button3, Set the window to floating mode and resize by dragging
      ((modm, button3),
   \ w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]

myKeys :: [(String, X ())]
myKeys = [
    ("M-S-e"             , spawn "emacs")
  , ("M-e"               , spawn "urxvt -e nvim")
  , ("M-f"               , spawn "urxvt -e lf")
  , ("M-S-f"             , spawn "spacefm")
  , ("M-i"               , spawn "browser")
  , ("M-S-i"             , spawn ("browser" ++ " --incognito"))
  , ("M-y"               , spawn "passmenu -nb '#9370DB' -nf '#50fa7b' -sb '#EE82EE' -sf black -fn 'monofur for Powerline'")
  , ("M-<Print>"         , spawn "flameshot gui -p $HOME/screenshots")
  , ("M-<F4>"         , spawn "exec flameshot gui -p $HOME/screenshots")
  -- , ("M-S-<Return>"      , spawn "tdrop -am -w 1355 -y 25 urxvt -name 'urxvt-float'")
  , ("M-<F12>"      , namedScratchpadAction myScratchPads "terminal")
  , ("M-<F11>"      , namedScratchpadAction myScratchPads "discord")
  -- , ("M-<F12>"      , spawn "tdrop -am -w 1355 -y 25 st -T 'st-float'")
  , ("M-S-<Return>"      , spawn "urxvt")
  , ("M-<Return>"        , spawn myTerminal)
  , ("M1-<Tab>"          , nextMatch Backward (return True))
       -- ,("M-<F5>"      ,toggleFocus)
  -- , ("M1-<Tab>"          , spawn "xeyes")
  , ("M-S-<Backspace>"   , spawn "xdo close")
  , ("M-S-<Escape>"      , spawn "wm-exit xmonad")
  , ("M-<Escape>"        , spawn "xmonad --restart")
  , ("M-S-p"             , spawn "dmenu_run -nb '#9370DB' -nf '#50fa7b' -sb '#EE82EE' -sf black -fn 'monofur for Powerline'")
  -- , ((modMask x , xK_p), spawn "passmenu --type")
  -- , ((modMask x .|. shiftMask, xK_p), spawn "lastpass-dmenu --typeit-login")
  -- , ("M-p"               , spawn "clipmenu -nb '#9370DB' -nf '#50fa7b' -sb '#EE82EE' -sf black -fn 'monofur for Powerline'")
  , ("M-v"               , sendKey noModMask xF86XK_Paste)
  -- , ("M-S-v"               , sendKey noModMask xF86XK_Select)
  , ("M-b"               , spawn "redshift -O 3500")
  , ("M-S-b"             , spawn "redshift -x")
  , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
  , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
  , ("<XF86AudioMute>", spawn "amixer set Master toggle")
  , ("<XF86AudioPlay>", spawn "mpc toggle")
  , ("<XF86AudioPrev>", spawn "mpc prev")
  , ("<XF86AudioNext>", spawn "mpc next")
  -- , ("M-<F1>", spawnToWorkspace "discord-flatpak" ws9)
  , ("M-<F2>", spawnToWorkspace "spacefm" ( myWorkspaces !! 7 ))
  , ("M-<F3>", spawn "intellij")
  , ("M-C-t", spawn ("st" ++ " -e htop"))
  , ("M-C-n", spawn ("st" ++ " -e newsboat"))
  , ("M-C-f", spawn ("st" ++ " -e lf"))
  , ("M-C-e", spawn ("st" ++ " -e nvim"))
  , ("M-C-m", spawn ("st" ++ " -e ncpamixer"))
  , ("M-m", windows W.focusMaster)
  , ("M-j", windows W.focusDown)
  , ("M-k", windows W.focusUp)
  , ("M-S-m", windows W.swapMaster)
  , ("M-S-j", windows W.swapDown)
  , ("M-S-k", windows W.swapUp)
  , ("M-<Up>", sendMessage (MoveUp 10))
  , ("M-<Down>", sendMessage (MoveDown 10))
  , ("M-<Right>", sendMessage (MoveRight 10))
  , ("M-<Left>", sendMessage (MoveLeft 10))
  , ("M-S-<Up>", sendMessage (IncreaseUp 10))
  , ("M-S-<Down>", sendMessage (IncreaseDown 10))
  , ("M-S-<Right>", sendMessage (IncreaseRight 10))
  , ("M-S-<Left>", sendMessage (IncreaseLeft 10))
  , ("M-C-<Up>", sendMessage (DecreaseUp 10))
  , ("M-C-<Down>", sendMessage (DecreaseDown 10))
  , ("M-C-<Right>", sendMessage (DecreaseRight 10))
  , ("M-C-<Left>", sendMessage (DecreaseLeft 10))
  ]
    -- Appending search engine prompts to keybindings list.
    ++ [("M-s " ++ k, S.promptSearch myXPConfig' f) | (k,f) <- searchList ]
    ++ [("M-S-s " ++ k, S.selectSearch f) | (k,f) <- searchList ]
    -- change active workspace
    ++ [("M-" ++ ws, windows $ W.greedyView ws) | ws <- myWorkspaces ]
    -- move window and change active workspace
    ++ [("M-S-" ++ ws, windows $ W.greedyView ws . W.shift ws) | ws <- myWorkspaces ]
    -- move window
    ++ [("M1-S-" ++ ws, windows $ W.shift ws) | ws <- myWorkspaces ]
    -- ++ [("M1-S-1",     windows $ W.shift ws1)
    --   , ("M1-S-2",     windows $ W.shift ws2) ]

-- haskell is 0-indexed
myManageHook = composeAll
    [ className =? "MPlayer"          --> doFloat
    , title     =? "urxvt-float"      --> doFloat --custom window title
    , title     =? "st-float"         --> doFloat --custom window title
    , className =? "Gimp"             --> doFloat
    , className =? "Emacs"            --> viewShift ( myWorkspaces !! 6 )
    -- , className =? "discord"          --> viewShift ( myWorkspaces !! 8 )
    , title     =? "Oracle VM VirtualBox Manager"  --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> doFloat
    , title     =? "Welcome to IntelliJ IDEA"      --> viewShift ( myWorkspaces !! 4 )
    , className =? "audacity"                      --> doFloat
    , className =? "audacity"                      --> viewShift ( myWorkspaces !! 5 )
    , className =? "Audacity"                      --> doFloat
    , className =? "Audacity"                      --> viewShift ( myWorkspaces !! 5 )
    , className =? "jetbrains-idea"   --> doFloat
    , className =? "jetbrains-idea"   --> viewShift ( myWorkspaces !! 4 )
    , resource  =? "desktop_window"   --> doIgnore -- TODO: not sure what this does
    -- Float flameshot's imgur window
    -- , className =? "flameshot" <&&> fmap (isInfixOf "Upload to Imgur") title --> doFloat
    , className =? "feh"              --> doFloat
    , role      =? "pop-up"           --> doFloat
    , title     =? "Discord Updater" --> doFloat
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
    , (className =? "Notepadqq" <&&> title =? "Search") --> doFloat
    , (className =? "Notepadqq" <&&> title =? "Advanced Search") --> doFloat
    , className =? "Xmessage" --> doFloat
    , role =? "browser" --> viewShift ( myWorkspaces !! 3 )
    ]  <+> namedScratchpadManageHook myScratchPads
  where
    role = stringProperty "WM_WINDOW_ROLE"
    viewShift = doF . liftM2 (.) W.greedyView W.shift
    -- myShift = doF . liftM2 (.) W.greedyView

myManageHook' = composeOne [ isFullscreen -?> doFullFloat ]

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                 , NS "discord" spawnDiscord findDiscord manageDiscord ]
    where
    full = customFloating $ W.RationalRect 0.05 0.05 0.9 0.9
    top = customFloating $ W.RationalRect 0.0 0.0 1.0 0.5
    h = 0.9
    w = 0.9
    t = 0.95 -h
    l = 0.95 -w
    spawnTerm  = "st" ++  " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
    -- manageTerm = customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)
    spawnDiscord  = "discord-flatpak"
    findDiscord   = resource =? "discord"
    manageDiscord = customFloating $ W.RationalRect l t w h
    -- manageDiscord = customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)

myAddSpaces :: Int -> String -> String
myAddSpaces len str = sstr ++ replicate (len - length sstr) ' '
  where
    sstr = shorten len str

polybarOutput str =
  io $ appendFile "/tmp/.xmonad-info" (str ++ "\n")

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

polybarLogHook = def
    { ppOutput = polybarOutput
    , ppCurrent = wrap ("%{B" ++ "#400473" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e
    -- , ppCurrent = wrap ("%{B" ++ "#008000" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e --background green
    -- , ppCurrent = wrap ("%{B" ++ "#343434" ++ "}" ++ "%{F" ++ "#FF69B4" ++ "}") " %{B- F-}" . wrap "[" "]" -- hotpink foreground, could try ff1d8e
    , ppVisible = wrap ("%{F" ++ "#FF1493" ++ "} ") " %{F-}"
    , ppHiddenNoWindows = wrap ("%{F" ++ "#928374" ++ "} ") " %{F-}" --lightgrey foreground
    , ppUrgent = wrap ("%{F" ++ "#FF0000" ++ "} ") " %{F-}"  --red foreground
    , ppHidden = wrap " " " "
    , ppWsSep = ""
    , ppSep = " %{F#928374}|%{F-} "
    , ppTitle = myAddSpaces 25
    , ppExtras  = [windowCount]                           -- # of windows current works
    }

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace = do
                       spawn program
                       windows $ W.greedyView workspace . W.shift workspace

myStartupHook :: X ()
myStartupHook = do
    setWMName "LG3D"
    liftIO (setEnv "DESKTOP_SESSION" "xmonad")
    spawnOnce "$HOME/.config/polybar/launch.sh xmonad"
    spawnOnce "flameshot" --dbus required
    spawnOnce "dunst"
    -- spawnOnce "picom"
    spawnOnce "sxhkd -c ~/.config/sxhkd/sxhkdrc-xmonad"
    -- spawn "clipmenud" --should I run copyq or clipmenu
    spawnOnce "copyq"
    spawnOn "1" "alacritty"
    spawnOn "2" "alacritty"
    spawnOnce "blueman-applet" --dbus required
    spawnOnce "nm-applet"
    spawnOnce "pamac-tray"
    spawnOnce "numlockx on"
    spawnOnce "conky -c $HOME/.xmonad/system-overview"
    spawnOnce "mpDris2" -- required for mpd
    spawnOnce "volumeicon"
    spawnOnce "xscreensaver -no-splash"
    spawnOnce "feh --bg-scale $HOME/backgrounds/minnesota-vikings-dark.jpg"
    -- spawnToWorkspace "discord-flatpak" "9"

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
  , handleEventHook = docksEventHook
      <+> minimizeEventHook
      <+> fullscreenEventHook -- may have negative impact to flameshot
  , startupHook = myStartupHook
  , focusFollowsMouse = False
  , clickJustFocuses = False
  , borderWidth = myBorderWidth
  , normalBorderColor = myBorderColor
  , focusedBorderColor = myFocusBorderColor
  , workspaces = myWorkspaces
  , modMask = superKeyMask
  }
   `additionalKeysP`
   [
   ]
   `additionalKeys`
   [
   ]