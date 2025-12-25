if not _G.charSelectExists then return end

local curFlyingObj = nil

---@param o Object
local function bhv_flying_leek_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    network_init_object(o, true, {})
end

---@param o Object
local function bhv_flying_leek_loop(o)
    local m = gMarioStates[network_local_index_from_global(o.globalPlayerIndex)]
    local np = gNetworkPlayers[m.playerIndex]
    local node = o.header.gfx.node

    obj_copy_pos(o, m.marioObj)
    obj_copy_angle(o, m.marioObj)

    node.flags = node.flags & ~GRAPH_RENDER_ACTIVE

    if o.oTimer < 18 or (m.action == ACT_JUMBO_STAR_CUTSCENE and m.actionArg < 2) then return end

    obj_scale(o, approach_f32_asymptotic(o.header.gfx.scale.x, 1.0, 0.2))

    if m.marioBodyState.capState & MARIO_HAS_WING_CAP_ON ~= 0 then
        node.flags = node.flags | GRAPH_RENDER_ACTIVE
    end

    if (m.action == ACT_FLYING or m.action == ACT_JUMBO_STAR_CUTSCENE) and o.oAction == 0 and np.connected and np.currAreaSyncValid then return end

    spawn_mist_particles()
    obj_mark_for_deletion(o)
end

id_bhvFlyingLeek = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_flying_leek_init, bhv_flying_leek_loop,
    'bhvFlyingLeek')

local function on_character_select_load()
    local FLYING_OBJ_MODELS = {
        [CT_MIKU] = smlua_model_util_get_id('miku_leek_geo'),
        [CT_TETO] = smlua_model_util_get_id('teto_baguette_geo'),
        [CT_NERU] = smlua_model_util_get_id('neru_phone_geo'),
    }

    local function spawn_leek_obj(globalIndex, pos, modelId)
        curFlyingObj = spawn_sync_object(id_bhvFlyingLeek, modelId, pos.x, pos.y, pos.z,
            ---@param o Object
            function(o)
                o.globalPlayerIndex = globalIndex
                obj_scale(o, 0.05)
            end)
    end

    local function on_set_action(m)
        if m.playerIndex ~= 0 or gPlayerSyncTable[0].mikuAnimsOff then return end
        if (m.action == ACT_FLYING or m.action == ACT_JUMBO_STAR_CUTSCENE) and not curFlyingObj and not CLASSIC_MODELS[_G.charSelect.gCSPlayers[m.playerIndex].modelId] then
            local charNum = _G.charSelect.character_get_current_number()
            if FLYING_OBJ_MODELS[charNum] then
                spawn_leek_obj(m.marioObj.globalPlayerIndex, m.pos, FLYING_OBJ_MODELS[charNum])
            end
        else
            curFlyingObj = nil
        end
    end
    hook_event(HOOK_ON_SET_MARIO_ACTION, on_set_action)

    local function on_sync()
        if gPlayerSyncTable[0].mikuAnimsOff then return end
        local m = gMarioStates[0]
        if (m.action == ACT_FLYING or m.action == ACT_JUMBO_STAR_CUTSCENE) and not curFlyingObj and not CLASSIC_MODELS[_G.charSelect.gCSPlayers[m.playerIndex].modelId] then
            local charNum = _G.charSelect.character_get_current_number()
            if FLYING_OBJ_MODELS[charNum] then
                spawn_leek_obj(m.marioObj.globalPlayerIndex, m.pos, FLYING_OBJ_MODELS[charNum])
            end
        end
    end
    hook_event(HOOK_ON_SYNC_VALID, on_sync)

    local function on_character_change(prevChar, currChar)
        if gPlayerSyncTable[0].mikuAnimsOff then return end
        local m = gMarioStates[0]
        if m.action ~= ACT_FLYING then return end
        local currFlyingModel = FLYING_OBJ_MODELS[currChar]
        if curFlyingObj then
            curFlyingObj.oAction = 1
            network_send_object(curFlyingObj, true)
            curFlyingObj = nil
        end
        if currFlyingModel and not CLASSIC_MODELS[_G.charSelect.gCSPlayers[m.playerIndex].modelId] then
            spawn_leek_obj(m.marioObj.globalPlayerIndex, m.pos, currFlyingModel)
        end
    end
    _G.charSelect.hook_on_character_change(on_character_change)

    function on_animation_toggle(value)
        if value then
            local m = gMarioStates[0]
            if (m.action == ACT_FLYING or m.action == ACT_JUMBO_STAR_CUTSCENE) and not curFlyingObj and not CLASSIC_MODELS[_G.charSelect.gCSPlayers[m.playerIndex].modelId] then
                local charNum = _G.charSelect.character_get_current_number()
                if FLYING_OBJ_MODELS[charNum] then
                    spawn_leek_obj(m.marioObj.globalPlayerIndex, m.pos, FLYING_OBJ_MODELS[charNum])
                end
            end
        else
            if curFlyingObj then
                curFlyingObj.oAction = 1
                network_send_object(curFlyingObj, true)
                curFlyingObj = nil
            end
        end
    end
end

hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
