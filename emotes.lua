local emoteTable = {}

local ICON_DEFAULT = get_texture_info('emote_icon_default')

---@param luaAnimId string
---@param name? string
---@param icon? TextureInfo
---@param audio? ModAudio
---@param characterNums? integer|integer[]
---@param loopFunc? fun(m:MarioState,curFrame:integer)
function add_emote(luaAnimId, name, icon, audio, characterNums, loopFunc)
    local emoteEntry = {anim = luaAnimId, name = name or luaAnimId, icon = icon, audio = audio, func = loopFunc}
    if characterNums then
        if type(characterNums) ~= "table" then
            emoteEntry.characters = {characterNums}
        else
            emoteEntry.characters = characterNums
        end
    end

    table.insert(emoteTable, emoteEntry)
end

local ACT_EMOTING = allocate_mario_action(ACT_GROUP_CUTSCENE)

---@param m MarioState
local function act_emoting(m)
    local emote = emoteTable[gPlayerSyncTable[m.playerIndex].playingEmote]

    set_character_animation(m, -1)
    smlua_anim_util_set_animation(m.marioObj, emote.luaAnimId)

    if emote.func then emote.func(m, m.marioObj.header.gfx.animInfo.animFrame) end
end
hook_mario_action(ACT_EMOTING, act_emoting)

-- only call in an actionable ground state
---@param m MarioState
function play_emote(m, emoteIndex)
    gPlayerSyncTable[m.playerIndex].playingEmote = emoteIndex

    set_mario_action(m, ACT_EMOTING, 0)
end