local openTimer = 0
local mainOption = 1
local subOption = 1
local subMenu = "main"

local MENU_OPTIONS = {
    {label = "Emotes", desc = "Select Vocaloid emotes to perform."},
    {label = "Jukebox", desc = "Listen to the Triple Baka Pack OST."},
    {label = "Gallery", desc = "Look through various artworks from the Triple Baka Pack."},
    {label = "Options", desc = "Customize your experience."}
}

local function tb_render_menu()
    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(FONT_ALIASED)

    local curMenu = MENU_OPTIONS

    local width = djui_hud_get_screen_width()
    local height = djui_hud_get_screen_height()

    local y = height / 8

    -- render

    djui_hud_set_color(255, 255, 255, openTimer * 63)
    djui_hud_render_rect(0, 0, width, height)

    for i = 1, #curMenu do
        local button = curMenu[i]

        
    end
end

hook_event(HOOK_ON_HUD_RENDER, function ()
    if openTimer ~= 0 then
        tb_render_menu()
    end
end)