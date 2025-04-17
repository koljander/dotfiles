local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then config = wezterm.config_builder() end

--Settings
config.color_scheme = "Github Dark" 
config.font = wezterm.font_with_fallback({
    {family = "UbuntuSansMono Nerd Font", scale = 2.2},
    {family = "UbuntuSansMono Nerd Font", scale = 2.2},
})
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "default"


--Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0.24,
    brightness = 0.5
}

--keys
config.leader = {key = "b", mods = "CTRL", timeout_milliseconds = 4000}
config.keys = {
    {key = "c", mods = "LEADER", action = act.ActivateCopyMode},

    --Pane Bindings
    {key = "-", mods = "LEADER", 
        action = act.SplitVertical {domain="CurrentPaneDomain"}},
    {key = "|", mods = "LEADER|SHIFT", 
        action = act.SplitHorizontal {domain="CurrentPaneDomain"}},
    {key = "x", mods = "LEADER", 
        action = act.CloseCurrentPane {confirm=true}},
    {key = "z", mods = "LEADER", 
        action = act.TogglePaneZoomState},
    {key = "s", mods = "LEADER", 
        action = act.RotatePanes "Clockwise"},
    {key = "r", mods = "LEADER", 
        action = act.ActivateKeyTable {name="resize_pane",one_shot=false}},

    --Pane Navigation
    {key = "h", mods = "LEADER", 
        action = act.ActivatePaneDirection("Left")},
    {key = "j", mods = "LEADER", 
        action = act.ActivatePaneDirection("Down")},
    {key = "k", mods = "LEADER", 
        action = act.ActivatePaneDirection("Up")},
    {key = "l", mods = "LEADER", 
        action = act.ActivatePaneDirection("Right")},
    

    --Tab Bindings
    {key = "n", mods = "LEADER", 
        action = act.SpawnTab("CurrentPaneDomain")},
    {key = "[", mods = "LEADER", 
        action = act.ActivateTabRelative(-1)},
    {key = "]", mods = "LEADER", 
        action = act.ActivateTabRelative(1)},
    {key = "t", mods = "LEADER", 
        action = act.ShowTabNavigator},
    {key = "m", mods = "LEADER", 
        action = act.ActivateKeyTable {name="move_tab",one_shot=false}},


    --Workspaces
    {key = "N", mods = "LEADER", action = act.SwitchWorkspaceRelative(1)},
    {key = "P", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1)},
    {key = "w", mods = "LEADER", 
        action = act.ShowLauncherArgs {flags="FUZZY|WORKSPACES"}},
    {key = "W", mods = "LEADER", 
        action = act.PromptInputLine {
            description = wezterm. format {
                {Attribute = {Intensity="Bold"}},
                {Foreground = {AnsiColor="Fuchsia"}},
                {Text = "Enter name for new workspace"},
            },
            action = wezterm.action_callback(function(window,pane,line)
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },

}

 
--Navigate tabs using the index
for i=1,9 do
    table.insert(config.keys, {
        key=tostring(i),
        mods="LEADER",
        action=act.ActivateTab(i-1)
    })
end



config.key_tables = {
    resize_pane = {
        {key="h", action=act.AdjustPaneSize{"Left",1}},
        {key="j", action=act.AdjustPaneSize{"Down",1}},
        {key="k", action=act.AdjustPaneSize{"Up",1}},
        {key="l", action=act.AdjustPaneSize{"Right",1}},
        {key="Escape", action="PopKeyTable"},
        {key="Enter", action="PopKeyTable"},
    },
    move_tab = {
        {key="h", action=act.MoveTabRelative(-1)},
        {key="j", action=act.MoveTabRelative(-1)},
        {key="k", action=act.MoveTabRelative(1)},
        {key="l", action=act.MoveTabRelative(1)},
        {key="Escape", action="PopKeyTable"},
        {key="Enter", action="PopKeyTable"},
    }


}


--Tab bar
--More tab bar settings
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
wezterm.on("update-right-status", function (window, pane)
    --Top right text
    --Display workspace or leader/table
    local stat = window:active_workspace()
    if window:active_key_table() then stat = window:active_key_table() end
    if window:leader_is_active() then stat = "LDR" end

    --local basename = function(s)
        --return string.gsub(s, "(.*[/\\])(.*)", "%2")
    --end
    --local cwd = basename(pane:get_current_working_dir().file_path)
    --local cmd = basename(pane:get_foreground_process_name())

    window:set_right_status(wezterm.format({
        {Text= wezterm.nerdfonts.oct_table .. "  " .. stat},
        {Text= "  "},
        --{Text= wezterm.nerdfonts.md_folder .. "  " .. cwd},
        --{Text= " | "},
        --{Text= wezterm.nerdfonts.fa_code .. "  " .. cmd},
        --{Text= " | "} 
    }))
end)


return config

