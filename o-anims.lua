local function on_character_select_load()
    local ANIMTABLE = {
        [CT_MIKU] = {
            [CHAR_ANIM_SINGLE_JUMP] = 'MikuJump',
            [CHAR_ANIM_IDLE_HEAD_LEFT] = 'MikuIdle',
            [CHAR_ANIM_IDLE_HEAD_CENTER] = 'MikuIdle',
            [CHAR_ANIM_IDLE_HEAD_RIGHT] = 'MikuIdle',
            [CHAR_ANIM_FIRST_PERSON] = 'MikuIdle',
            [CHAR_ANIM_RUNNING] = 'MikuRun',
            [CHAR_ANIM_WING_CAP_FLY] = 'MikuFlying',
            [CHAR_ANIM_FORWARD_SPINNING_FLIP] = 'MikuBeginFly',
            [CHAR_ANIM_FLY_FROM_CANNON] = 'MikuCannonFly',
            [CHAR_ANIM_FINAL_BOWSER_WING_CAP_TAKE_OFF] = 'MikuCreditsFly',
        },
        [CT_TETO] = {
            [CHAR_ANIM_SINGLE_JUMP] = 'MikuJump',
            [CHAR_ANIM_IDLE_HEAD_LEFT] = 'TetoIdle',
            [CHAR_ANIM_IDLE_HEAD_CENTER] = 'TetoIdle',
            [CHAR_ANIM_IDLE_HEAD_RIGHT] = 'TetoIdle',
            [CHAR_ANIM_FIRST_PERSON] = 'TetoIdle',
            [CHAR_ANIM_RUNNING] = 'MikuRun',
            [CHAR_ANIM_WING_CAP_FLY] = 'MikuFlying',
            [CHAR_ANIM_FORWARD_SPINNING_FLIP] = 'MikuBeginFly',
            [CHAR_ANIM_FLY_FROM_CANNON] = 'MikuCannonFly',
            [CHAR_ANIM_FINAL_BOWSER_WING_CAP_TAKE_OFF] = 'MikuCreditsFly',
        },
        [CT_NERU] = {
            [CHAR_ANIM_SINGLE_JUMP] = 'MikuJump',
            [CHAR_ANIM_IDLE_HEAD_LEFT] = 'NeruIdle',
            [CHAR_ANIM_IDLE_HEAD_CENTER] = 'NeruIdle',
            [CHAR_ANIM_IDLE_HEAD_RIGHT] = 'NeruIdle',
            [CHAR_ANIM_FIRST_PERSON] = 'NeruIdle',
            [CHAR_ANIM_RUNNING] = 'MikuRun',
            [CHAR_ANIM_WING_CAP_FLY] = 'NeruFlying',
            [CHAR_ANIM_FORWARD_SPINNING_FLIP] = 'NeruBeginFly',
            [CHAR_ANIM_FLY_FROM_CANNON] = 'NeruCannonFly',
            [CHAR_ANIM_FINAL_BOWSER_WING_CAP_TAKE_OFF] = 'NeruCreditsFly',
        }
    }

    gPlayerSyncTable[0].mikuAnimsOff = mod_storage_load_bool("mikuanims")

    local init = false
    local function on_sync()
        if init then return end
        gPlayerSyncTable[0].mikuAnimsOff = mod_storage_load_bool("mikuanims")
        init = true
    end
    hook_event(HOOK_ON_SYNC_VALID, on_sync)

    ---@param m MarioState
    local function before_update(m)
        if gPlayerSyncTable[m.playerIndex].mikuAnimsOff then return end
        local charNum = _G.charSelect.character_get_current_number(m.playerIndex)
        if not charNum then return end
        local animTable = ANIMTABLE[charNum]
        if not animTable or CLASSIC_MODELS[_G.charSelect.gCSPlayers[m.playerIndex].modelId] then return end
        local anim = animTable[m.marioObj.header.gfx.animInfo.animID]
        if anim then
            smlua_anim_util_set_animation(m.marioObj, anim)

            if m.action == ACT_IDLE then
                m.actionTimer = m.actionTimer + 1
                if m.actionTimer > 900 then
                    m.actionState = 3
                else
                    m.actionState = 0
                end
            end
        end
    end
    hook_event(HOOK_BEFORE_MARIO_UPDATE, before_update)

    if charSelect.version_get_full().major < 16 then
        ---@param m MarioState
        local function set_cs_hand_state(m)
            if m.marioObj.header.gfx.animInfo.animID == _G.charSelect.CS_ANIM_MENU then
                m.marioBodyState.handState = MARIO_HAND_PEACE_SIGN
            end
        end
        _G.charSelect.character_hook_moveset(CT_MIKU, HOOK_MARIO_UPDATE, set_cs_hand_state)
        _G.charSelect.character_hook_moveset(CT_NERU, HOOK_MARIO_UPDATE, set_cs_hand_state)
    end
end
hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)

local function mikuanims_toggle(index, value)
    gPlayerSyncTable[0].mikuAnimsOff = value
    mod_storage_save_bool("mikuanims", value)

    on_animation_toggle(value)
end

hook_mod_menu_checkbox("Vanilla Animations", mod_storage_load_bool("mikuanims"), mikuanims_toggle)
