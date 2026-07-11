---@type HL.PermissionSpec[]
local perms = {
    {
        binary = "/usr/(bin|local/bin)/grim",
        type = "screencopy",
        mode = "allow",
    },
    {
        binary = "/usr/(bin|local/bin)/hyprlock",
        type = "screencopy",
        mode = "allow",
    },
    {
        binary = "/usr/(bin|local/bin)/hyprpicker",
        type = "screencopy",
        mode = "allow",
    },
    {
        binary = "/usr/(bin|local/bin)/slurp",
        type = "screencopy",
        mode = "allow",
    },
    {
        binary = "/usr/(bin|local/bin)/hyprpm",
        type = "plugin",
        mode = "allow",
    },
}

for _, perm in pairs(perms) do
    hl.permission(perm)
end
