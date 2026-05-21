local dsp_exec_cmd = hl.dsp.exec_cmd
local dsp_layout = hl.dsp.layout
local dsp_window_move = hl.dsp.window.move
local dsp_focus = hl.dsp.focus
local dispatch = hl.dispatch

local bind = hl.bind

local function bindl(keys, dispatcher, opts)
    opts = opts or {}
    opts.locked = true
    bind(keys, dispatcher, opts)
end

local function binde(keys, dispatcher, opts)
    opts = opts or {}
    opts.repeating = true
    bind(keys, dispatcher, opts)
end

local function bindel(keys, dispatcher, opts)
    opts = opts or {}
    opts.locked = true
    opts.repeating = true
    bind(keys, dispatcher, opts)
end

bind("SUPER + Return", dsp_exec_cmd("tutils terminal"))
bind("SUPER + E", dsp_exec_cmd("tutils file_explorer"))
bind("SUPER + SHIFT + E", dsp_exec_cmd("tutils powermenu"))
bind("SUPER + Space", dsp_exec_cmd("tutils launcher"))
bind("SUPER + C", dsp_exec_cmd("tutils color_picker --lock"))
bind("SUPER + SHIFT + C", function()
    local win_in_ws = hl.get_windows({
        workspace = hl.get_active_workspace(),
    })
    for _, win in pairs(win_in_ws) do
        if win.focus_history_id ~= 0 then
            dispatch(hl.dsp.window.close({ window = win }))
        end
    end
end)
bind("SUPER + S", dsp_exec_cmd("tutils emoji_picker"))
bind("SUPER + V", dsp_exec_cmd("tutils clipboard_picker --action pick"))
bind(
    "SUPER + SHIFT + V",
    dsp_exec_cmd("tutils clipboard_picker --action delete")
)
bind(
    "SUPER + CTRL + SHIFT + V",
    dsp_exec_cmd("tutils clipboard_picker --action wipe")
)
bind(
    "SUPER + PRINT",
    dsp_exec_cmd("tutils screenshot --lock --action savecopy --method area")
)
bind(
    "SUPER + CTRL + PRINT",
    dsp_exec_cmd("tutils screenshot --lock --action savecopy --method window")
)
bind(
    "SUPER + CTRL + SHIFT + PRINT",
    dsp_exec_cmd("tutils screenshot --lock --action savecopy --method output")
)
bind(
    "PRINT",
    dsp_exec_cmd("tutils screenshot --lock --action copy --method area")
)
bind(
    "CTRL + PRINT",
    dsp_exec_cmd("tutils screenshot --lock --action copy --method window")
)
bind(
    "CTRL + SHIFT + PRINT",
    dsp_exec_cmd("tutils screenshot --lock --action copy --method output")
)
bind("SUPER + B", dsp_exec_cmd("tutils status_bar --action toggle"))
bind("SUPER + SHIFT + B", dsp_exec_cmd("tutils status_bar --action refresh"))

bindel(
    "XF86AudioRaiseVolume",
    dsp_exec_cmd("tutils volume --device speaker --inc-percent 5")
)
bindel(
    "XF86AudioLowerVolume",
    dsp_exec_cmd("tutils volume --device speaker --dec-percent 5")
)
bindel(
    "XF86AudioMute",
    dsp_exec_cmd("tutils volume --device speaker --toggle-mute")
)
bindel(
    "XF86AudioMicMute",
    dsp_exec_cmd("tutils volume --device microphone --toggle-mute")
)
bindel(
    "XF86MonBrightnessUp",
    dsp_exec_cmd(
        "tutils brightness --device all --class backlight --inc-percent 5"
    )
)
bindel(
    "XF86MonBrightnessDown",
    dsp_exec_cmd(
        "tutils brightness --device all --class backlight --dec-percent 5"
    )
)

bindl("XF86AudioNext", dsp_exec_cmd("tutils player --next"))
bindl("XF86AudioPause", dsp_exec_cmd("tutils player --play-pause"))
bindl("XF86AudioPlay", dsp_exec_cmd("tutils player --play-pause"))
bindl("XF86AudioPrev", dsp_exec_cmd("tutils player --previous"))

bind("SUPER + F", hl.dsp.window.fullscreen())
bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
bind("SUPER + SHIFT + Q", hl.dsp.window.close())

if hl.get_config("general.layout") ~= "scrolling" then
    bind("SUPER + L", dsp_focus({ direction = "r" }))
    bind("SUPER + H", dsp_focus({ direction = "l" }))
    bind("SUPER + K", dsp_focus({ direction = "u" }))
    bind("SUPER + J", dsp_focus({ direction = "d" }))

    bind("SUPER + SHIFT + L", dsp_window_move({ direction = "r" }))
    bind("SUPER + SHIFT + H", dsp_window_move({ direction = "l" }))
    bind("SUPER + SHIFT + K", dsp_window_move({ direction = "u" }))
    bind("SUPER + SHIFT + J", dsp_window_move({ direction = "d" }))
else
    bind("SUPER + L", dsp_layout("focus r"))
    bind("SUPER + H", dsp_layout("focus l"))
    bind("SUPER + K", dsp_layout("focus u"))
    bind("SUPER + J", dsp_layout("focus d"))

    bind("SUPER + ALT + L", dsp_layout("swapcol r"))
    bind("SUPER + ALT + H", dsp_layout("swapcol l"))

    binde("SUPER + CTRL + L", dsp_layout("colresize +conf"))
    binde("SUPER + CTRL + H", dsp_layout("colresize -conf"))
end

for i = 0, 9 do
    local ws_id = i
    if i == 0 then
        ws_id = 10
    end
    bind("SUPER + " .. i, dsp_focus({ workspace = ws_id }))
    bind("SUPER + SHIFT + " .. i, dsp_window_move({ workspace = ws_id }))
end

bind("SUPER + N", dsp_focus({ workspace = "e+1" }))
bind("SUPER + P", dsp_focus({ workspace = "e-1" }))
bind("SUPER + bracketright", function()
    local ws = hl.get_active_workspace()
    if ws ~= nil and ws.id < 10 then
        dispatch(dsp_focus({ workspace = "+1" }))
    end
end)
bind("SUPER + bracketleft", function()
    local ws = hl.get_active_workspace()
    if ws ~= nil and ws.id > 0 then
        dispatch(dsp_focus({ workspace = "-1" }))
    end
end)
bind("SUPER + SHIFT + N", dsp_window_move({ workspace = "e+1" }))
bind("SUPER + SHIFT + P", dsp_window_move({ workspace = "e-1" }))
bind("SUPER + SHIFT + bracketright", function()
    local ws = hl.get_active_workspace()
    if ws ~= nil and ws.id < 10 then
        dispatch(dsp_window_move({ workspace = "+1" }))
    end
end)
bind("SUPER + SHIFT + bracketleft", function()
    local ws = hl.get_active_workspace()
    if ws ~= nil and ws.id > 0 then
        dispatch(dsp_window_move({ workspace = "-1" }))
    end
end)

bind("SUPER + tab", dsp_focus({ workspace = "previous" }))
bind("SUPER + SHIFT + tab", dsp_window_move({ workspace = "previous" }))
bind("ALT + tab", hl.dsp.window.cycle_next())
bind("ALT + SHIFT + tab", hl.dsp.window.cycle_next({ next = "prev" }))

bind("SUPER + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind("SUPER + SHIFT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- bindc=Caps_Lock, Caps_Lock, exec, swayosd-client --caps-lock
-- bindc=Mod2     , Num_Lock , exec, swayosd-client --num-lock
