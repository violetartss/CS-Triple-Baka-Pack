local PI, PI_2 = math.pi, math.pi * 2.0
local table_insert, round, atan, sin, cos = table.insert, math.round, math.atan, math.sin, math.cos

---@param n integer
---@param range integer
---@return integer
local function wrap(n, range)
    while n < 1 do
        n = n + range
    end
    while n > range do
        n = n - range
    end
    return n
end
---@param n number
---@param range number
---@return number
local function wrapf(n, range)
    while n < 0 do
        n = n + range
    end
    while n > range do
        n = n - range
    end
    return n
end

---@class Emote
---@field anim string
---@field name string
---@field icon? TextureInfo
---@field audio? ModAudio
---@field characters? table<integer,boolean>
---@field func? fun(m:MarioState,curFrame:integer)

---@type Emote[]
local emoteTable = {}

local emoteMenu = {
    open = false,
    selected = 1,
    cursorAngle = 0.0,
    availableEmotes = {} -- updated on emote wheel open
}

local TEX_ICON_DEFAULT = get_texture_info('emote_icon_default')
local TEX_WHEEL_SIMPLE = get_texture_info('emote_wheel_simple')

---@param luaAnimId string
---@param name? string
---@param icon? TextureInfo
---@param audio? ModAudio
---@param characterNums? integer|integer[]
---@param loopFunc? fun(m:MarioState,curFrame:integer) Function called every frame while the emote is playing. Passes the player's state `m` and `animFrame` as parameters. Return `true` to intercept the stationary ground step and cancels.
function add_emote(luaAnimId, name, icon, audio, characterNums, loopFunc)
    local emoteEntry = { anim = luaAnimId, name = name or luaAnimId, icon = icon, audio = audio, func = loopFunc }
    if characterNums then
        if type(characterNums) ~= "table" then
            emoteEntry.characters = { [characterNums] = true }
        else
            emoteEntry.characters = {}
            for i = 1, #characterNums do
                emoteEntry.characters[characterNums[i]] = true
            end
        end
    end

    table_insert(emoteTable, emoteEntry)
end

local ACT_EMOTING = allocate_mario_action(ACT_GROUP_CUTSCENE)

---@param m MarioState
local function act_emoting(m)
    local emote = emoteTable[gPlayerSyncTable[m.playerIndex].playingEmote]

    set_character_animation(m, -1)
    smlua_anim_util_set_animation(m.marioObj, emote.anim)
    local animInfo = m.marioObj.header.gfx.animInfo

    if emote.func then if emote.func(m, animInfo.animFrame) then return end end

    m.input = m.input & ~INPUT_NONZERO_ANALOG
    if check_common_idle_cancels(m) ~= 0 then
        return 1
    end

    stationary_ground_step(m)

    if animInfo.curAnim.flags & ANIM_FLAG_NOLOOP ~= 0 and is_anim_at_end(m) ~= 0 then
        set_mario_action(m, ACT_IDLE, 0)
    end
end
hook_mario_action(ACT_EMOTING, act_emoting)

---@param m MarioState
function play_emote(m, emoteIndex)
    if not emoteIndex or emoteIndex <= 0 then return end

    gPlayerSyncTable[m.playerIndex].playingEmote = emoteIndex
    drop_and_set_mario_action(m, ACT_EMOTING, 0)
end

---@param m MarioState
local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    local c = m.controller

    if emoteMenu.open then
        local numEmotes = #emoteMenu.availableEmotes
        if c.stickMag > 0.25 then
            emoteMenu.cursorAngle = wrapf(atan(c.stickX, -c.stickY), PI_2)
            --_G.quick_debug_log('stick', emoteMenu.cursorAngle)
            emoteMenu.selected = wrap(round((emoteMenu.cursorAngle / PI_2) * numEmotes), numEmotes)
            c.stickMag = 0.0
        end

        if c.buttonPressed & A_BUTTON ~= 0 and numEmotes > 0 then
            play_emote(m, emoteMenu.availableEmotes[emoteMenu.selected])
            emoteMenu.open = false
        end
        if c.buttonPressed & B_BUTTON ~= 0 then
            emoteMenu.open = false
        end

        c.buttonPressed = 0
        return
    end

    if m.action & ACT_FLAG_ALLOW_FIRST_PERSON ~= 0 and c.buttonDown & Z_TRIG ~= 0 and c.buttonPressed & R_TRIG ~= 0 then
        c.buttonPressed = c.buttonPressed & ~R_TRIG

        local charNum = _G.charSelect.character_get_current_number()

        emoteMenu.availableEmotes = {}
        for i = 1, #emoteTable do
            local characterNums = emoteTable[i].characters
            -- valid emote if whitelist unspecified, OR if character is on whitelist
            if not characterNums or characterNums[charNum] then
                table_insert(emoteMenu.availableEmotes, i)
            end
        end

        emoteMenu.open = true
    end
end
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)

local function on_hud_render()
    if not emoteMenu.open then return end

    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(FONT_TINY)

    local w = djui_hud_get_screen_width() / 2
    local h = djui_hud_get_screen_height() / 2

    local numEmotes = #emoteMenu.availableEmotes
    local angleDiff = PI_2 / numEmotes

    djui_hud_set_color(0xFF, 0xFF, 0xFF, 0xFF)
    djui_hud_render_texture(TEX_WHEEL_SIMPLE, w - 256, h - 256, 2.0, 2.0)

    local curAngle = angleDiff
    for i = 1, numEmotes do
        local emote = emoteTable[emoteMenu.availableEmotes[i]]

        local x = w + sin(curAngle) * 200
        local y = h + cos(curAngle) * 200
        local icon = emote.icon or TEX_ICON_DEFAULT

        djui_hud_set_color(0xFF, 0xFF, 0xFF, emoteMenu.selected == i and 0xFF or 0x7F)

        djui_hud_render_texture(icon, x - 32, y - 32, 64 / icon.width, 64 / icon.height)
        curAngle = curAngle + angleDiff
    end
    djui_hud_set_color(0xFF, 0xFF, 0xFF, 0xFF)

    

    local selectedName = emoteTable[emoteMenu.availableEmotes[emoteMenu.selected]].name
    djui_hud_print_text(selectedName, w - djui_hud_measure_text(selectedName), h - 16, 2.0)
end
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
