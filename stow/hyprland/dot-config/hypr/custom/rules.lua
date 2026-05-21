hl.on("monitor.added", function(mon)
    for i = 6, 10 do
        hl.workspace_rule({
            workspace = string.format("%d", i),
            monitor = mon,
            default = true,
        })
    end
end)

hl.window_rule({
    name = "Unity popup",
    match = {
        class = "^(Unity)$",
        float = true,
        title = [[^(UnityEditor\..*)$]],
    },
    stay_focused = true,
})

hl.window_rule({
    name = "Unity editor window",
    match = {
        class = "^(Unity)$",
        title = [[^(UnityEditor\..*)$]],
    },
    pin = true,
})

hl.window_rule({
    name = "Unity color picker",
    match = {
        class = "^(Unity)$",
        title = "^(.*Color)$",
    },
    center = true,
    float = true,
    min_size = { 1, 1 },
    no_blur = true,
    pin = true,
    stay_focused = true,
})

hl.window_rule({
    name = "Linux desktop gremlins",
    match = { title = "ilgwg_desktop_gremlins.py" },
    no_blur = true,
    no_shadow = true,
    border_size = 0,
    opacity = "1 override",
})
