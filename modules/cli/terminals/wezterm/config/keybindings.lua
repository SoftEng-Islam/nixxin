local M = {}
local wezterm = require 'wezterm'
-- Multiplexing config
local act = wezterm.action

-- leader key config
M.debug_key_events = true
M.leader = { mods = "CTRL", key = "b", timeout_milliseconds = 1000 }
M.keys   = {
  { mods = "CTRL", key = "L", action=act.ShowDebugOverlay },
  { mods = "LEADER|CTRL", key = ";",           action = act.SplitVertical    { domain = "CurrentPaneDomain" } },
  { mods = "LEADER|CTRL", key = "'",           action = act.SplitHorizontal  { domain = "CurrentPaneDomain" } },
  { mods = "LEADER|CTRL", key = "x",           action = act.CloseCurrentPane { confirm = false              } },
  { mods = "LEADER|CTRL", key = "h",           action = act.ActivatePaneDirection "Left"  },
  { mods = "LEADER|CTRL", key = "l",           action = act.ActivatePaneDirection "Right" },
  { mods = "LEADER|CTRL", key = "k",           action = act.ActivatePaneDirection "Up"    },
  { mods = "LEADER|CTRL", key = "j",           action = act.ActivatePaneDirection "Down"  },
  { mods = "LEADER|CTRL", key  = "a",          action = act.ActivateKeyTable { name = "activate_pane", one_shot = false } },
  { mods = "LEADER|CTRL", key  = "r",          action = act.ActivateKeyTable { name = "resize_pane"  , one_shot = false } },
  { mods = "LEADER|CTRL", key  = "c",          action = act.ActivateKeyTable { name = "rotate_pane"  , one_shot = false } },
  { mods = "LEADER|CTRL", key = "]",           action = act.RotatePanes "Clockwise"        },
  { mods = "LEADER|CTRL", key = "[",           action = act.RotatePanes "CounterClockwise" },
  { mods = "LEADER|CTRL", key = "p",           action = act{PaneSelect={alphabet="0123456789"}}},
}

M.key_tables = {
  activate_pane = {
    { key = 'LeftArrow',  action = act.ActivatePaneDirection 'Left'  },
    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow',    action = act.ActivatePaneDirection 'Up'    },
    { key = 'DownArrow',  action = act.ActivatePaneDirection 'Down'  },
    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left',  1 } },
    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up',    1 } },
    { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down',  1 } },
    { key = 'Escape',     action = 'PopKeyTable' },
  },
  rotate_pane = {
    { key = 'RightArrow', action = act.RotatePanes "CounterClockwise" },
    { key = 'UpArrow',    action = act.RotatePanes "CounterClockwise" },
    { key = 'LeftArrow',  action = act.RotatePanes "Clockwise"        },
    { key = 'DownArrow',  action = act.RotatePanes "Clockwise"        },
    { key = 'Escape',     action = 'PopKeyTable' },
  },
}

return M
