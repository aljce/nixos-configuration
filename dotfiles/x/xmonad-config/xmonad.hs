import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ToggleLayouts
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle.Instances
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Minimize
import XMonad.Layout.Fullscreen
import XMonad.Util.Paste

import System.Exit
import Control.Concurrent.MVar
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Monoid ((<>))

myTerminal = "st"

myFocusFollowsMouse = True

myBorderWidth = 1

myModMask = mod1Mask

myWorkspaces = ["1: WEB","2: CODE","3: SYS","4: COMM","5: ETC"] ++ map show [6..9]

myNormalBorderColor  = "#222226"

myFocusedBorderColor = "#5d4d7a"

myXmobarSelectColor  = "#ce537a"

myXmobarWindowColor  = "#bc6ec5"

myKeys conf =
  [ ("M-<Return>", spawn (terminal conf))
  , ("M-w",   spawn "google-chrome-stable")
  , ("M-e",   spawn "emacs")
  , ("<XF86MonBrightnessDown>", spawn "light -U 10")
  , ("<XF86MonBrightnessUp>"  , spawn "light -A 10")
  , ("<XF86AudioLowerVolume>" , spawn "pactl -- set-sink-volume -5%")
  , ("<XF86AudioRaiseVolume>" , spawn "pactl -- set-sink-volume +5%")
  , ("M-j",   windows W.focusDown)
  , ("M-S-j", windows W.swapDown)
  , ("M-k",   windows W.focusUp)
  , ("M-S-k", windows W.swapUp)
  , ("M-m",   windows W.focusMaster)
  , ("M-p",   pasteSelection)
  , ("M-n",   sendMessage NextLayout)
  , ("M-c",   kill)
  , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
  , ("M-S-q", io exitSuccess)
  ] ++
  [("M"++ shf ++ "-" ++ [wsId], windows (f ws))
  | (ws,wsId) <- zip (workspaces conf) "&[{}(=*)+]"
  , (f ,shf) <- [(W.greedyView,""),(\w -> W.greedyView w . W.shift w ,"-S")]]

myMouseBindings XConfig {XMonad.modMask = modm} = M.empty

myLayout = (avoidStruts . fullscreenFull) (nTall ||| full)
  where nTall = spacing 5 (Tall 1 (3/100) (1/2))
        full  = noBorders Full

myManageHook = manageDocks <> (isFullscreen --> doFullFloat)

myEventHook = docksEventHook

myLogHook xmproc = dynamicLogWithPP xmobarPP
                     { ppOutput = hPutStrLn xmproc
                     , ppCurrent = xmobarColor myXmobarWindowColor "" . wrap "[" "]"
                     , ppTitle = xmobarColor myXmobarSelectColor "" . shorten 50
                     }

myStartupHook conf= do
  return () --fixpoint of the startupHook, layoutHook loop
  checkKeymap conf (myKeys conf)

myConfig xmproc = def {
  terminal           = myTerminal,
  focusFollowsMouse  = myFocusFollowsMouse,
  borderWidth        = myBorderWidth,
  modMask            = myModMask,
  workspaces         = myWorkspaces,
  normalBorderColor  = myNormalBorderColor,
  focusedBorderColor = myFocusedBorderColor,
  keys               = mkKeymap <*> myKeys, -- Applicative for (->)
  mouseBindings      = myMouseBindings,
  layoutHook         = myLayout,
  manageHook         = myManageHook,
  handleEventHook    = myEventHook,
  logHook            = myLogHook xmproc,
  startupHook        = myStartupHook (myConfig xmproc) }


main :: IO ()
main = do
  spawn "/run/current-system/sw/bin/feh --bg-scale /usr/share/wallpaper"
  xmproc <- spawnPipe "/run/current-system/sw/bin/xmobar /home/amckean/.xmobarrc"
  xmonad $ myConfig xmproc
