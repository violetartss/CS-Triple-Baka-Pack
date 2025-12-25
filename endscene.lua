if not _G.charSelectExists then return end

mikuend = mod_storage_load_bool("mikuend")
TEX_CAKE = get_texture_info("miku_end")

function render_miku_end()
    if mikuend then
        local gSync = gPlayerSyncTable[0]

        local x = djui_hud_get_screen_width() / 2 - TEX_CAKE.width / 2
        local y = djui_hud_get_screen_height() / 2 - TEX_CAKE.height / 2

        if gNetworkPlayers[0].currLevelNum ~= LEVEL_ENDING then
            return
        end

        local charNum = _G.charSelect.character_get_current_number()
        if charNum == CT_MIKU or charNum == CT_TETO or charNum == CT_NERU then
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_render_rect(0, 0, djui_hud_get_screen_width(), djui_hud_get_screen_height())
            djui_hud_set_color(255, 255, 255, 255)

            djui_hud_set_filter(FILTER_LINEAR)
            djui_hud_render_texture(TEX_CAKE, x, y, 1, 1)
        end
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, function()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)

    djui_hud_set_color(255, 255, 255, 255)
    render_miku_end()
end)

local function on_thankyou(soundBits, pos)
    if mikuend and soundBits == SOUND_MENU_THANK_YOU_PLAYING_MY_GAME then
        local charNum = _G.charSelect.character_get_current_number()
        if charNum == CT_MIKU or charNum == CT_TETO or charNum == CT_NERU then
            local thankYouSound = audio_stream_load("MikuSayonara.ogg")
            audio_stream_play(thankYouSound, false, 2.0)
            return NO_SOUND
        end
    end
end

local function mikuendToggle(index, value)
    mikuend = value
    mod_storage_save_bool("mikuend", value)
end

hook_event(HOOK_ON_PLAY_SOUND, on_thankyou)
hook_mod_menu_checkbox("Custom End Screen", mod_storage_load_bool("mikuend"), mikuendToggle)

-- end screen code by King The Memer
-- thank you code by Baconator2558
