if not _G.charSelectExists then return end

mikuoldmusic = mod_storage_load_bool("mikuoldmusic")
mikunewmusic = mod_storage_load_bool("mikunewmusic")
mikucaps = mod_storage_load_bool("mikucaps")

local SEQ_MIKU_POWERUP = SEQ_COUNT + 16
local SEQ_MIKU_VANISH = SEQ_COUNT + 32
local SEQ_MIKU_METAL = SEQ_COUNT + 64
local SEQ_MIKU_CREDITS = SEQ_COUNT + 65
local SEQ_MIKUNEW_CREDITS = audio_stream_load("MikuEnding.ogg")

smlua_audio_utils_replace_sequence(SEQ_MIKU_CREDITS, 0x25, 80, "MikuCredits")
smlua_audio_utils_replace_sequence(SEQ_MIKU_POWERUP, 0x17, 80, "MikuWing")
smlua_audio_utils_replace_sequence(SEQ_MIKU_VANISH, 0x17, 80, "NeruVanish")
smlua_audio_utils_replace_sequence(SEQ_MIKU_METAL, 0x18, 80, "MikuMetal")

local function on_mikuseqload(player, seqID)
    audio_stream_stop(SEQ_MIKUNEW_CREDITS)
    subtitleTimer = -1

    local charNum = _G.charSelect.character_get_current_number()
    if charNum == CT_MIKU or charNum == CT_TETO or charNum == CT_NERU then
        if mikunewmusic then
            if seqID == SEQ_EVENT_CUTSCENE_CREDITS then
                sound_reset_background_music_default_volume(SEQ_EVENT_POWERUP)
                stop_cap_music()
                stop_shell_music()
                audio_stream_play(SEQ_MIKUNEW_CREDITS, false, 1.0)
                subtitleTimer = 0
                return 0 -- cancel the original SEQ
            end
        end
        if mikuoldmusic and not mikunewmusic then
            if seqID == SEQ_EVENT_CUTSCENE_CREDITS then
                sound_reset_background_music_default_volume(SEQ_EVENT_POWERUP)
                stop_cap_music()
                stop_shell_music()
                return SEQ_MIKU_CREDITS
            end
        end
        if mikucaps then
            if (gMarioStates[0].flags & MARIO_VANISH_CAP ~= 0 and seqID == SEQ_EVENT_POWERUP) then
                return SEQ_MIKU_VANISH
            elseif (seqID == SEQ_EVENT_POWERUP) then
                return SEQ_MIKU_POWERUP
            elseif (seqID == SEQ_EVENT_CUTSCENE_COLLECT_STAR) then
                return SEQ_EVENT_CUTSCENE_COLLECT_STAR;
            elseif (seqID == SEQ_MENU_STAR_SELECT) then
                return SEQ_MENU_STAR_SELECT
            elseif (seqID == SEQ_EVENT_METAL_CAP) then
                return SEQ_MIKU_METAL
            end
        end
    end
end

local function mikucapsToggle(index, value)
    mikucaps = value
    mod_storage_save_bool("mikucaps", value)
end

local function mikuoldmusicToggle(index, value)
    mikuoldmusic = value
    mod_storage_save_bool("mikuoldmusic", value)
end

local function mikunewmusicToggle(index, value)
    mikunewmusic = value
    mod_storage_save_bool("mikunewmusic", value)
end

hook_event(HOOK_ON_SEQ_LOAD, on_mikuseqload)

hook_mod_menu_checkbox("Custom Cap Music", mod_storage_load_bool("mikucaps"), mikucapsToggle)
hook_mod_menu_checkbox("Anamanaguchi Miku Ending Music (Legacy)", mod_storage_load_bool("mikuoldmusic"),
    mikuoldmusicToggle)
hook_mod_menu_checkbox("Jump Jump Jump UP!!! Ending Music (Recommended)", mod_storage_load_bool("mikunewmusic"),
    mikunewmusicToggle)

-- Music Code by Baconator2558 and ManisCat
-- Option Code by SwagSkeleton
