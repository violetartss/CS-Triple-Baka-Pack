if not _G.charSelectExists then return end

mikueyes = mod_storage_load_bool("mikueyes")

local function s16(x)
    x = (math.floor(x) & 0xFFFF)
    if x >= 32768 then return x - 65536 end
    return x
end

local MikuEyeHurtActs = {
    --[act] = true,
    [ACT_GETTING_BLOWN] = true,
    [ACT_THROWN_FORWARD] = true,
    [ACT_THROWN_BACKWARD] = true,
    [ACT_SHOCKED] = true,
    [ACT_SQUISHED] = true,
    [ACT_CAUGHT_IN_WHIRLPOOL] = true,
    [ACT_HARD_BACKWARD_GROUND_KB] = true,
}
local MikuEyeHurtActsConditional = {
    [ACT_SOFT_BACKWARD_GROUND_KB] = true,
    [ACT_BACKWARD_GROUND_KB] = true,
    [ACT_BACKWARD_AIR_KB] = true,
    [ACT_HARD_BACKWARD_AIR_KB] = true,
    [ACT_BACKWARD_WATER_KB] = true,
    [ACT_SOFT_FORWARD_GROUND_KB] = true,
    [ACT_FORWARD_GROUND_KB] = true,
    [ACT_HARD_FORWARD_GROUND_KB] = true,
    [ACT_FORWARD_AIR_KB] = true,
    [ACT_HARD_FORWARD_AIR_KB] = true,
    [ACT_FORWARD_WATER_KB] = true,
}

local MikuEyeHappyActs = {
    [ACT_TRIPLE_JUMP_LAND] = true,
    [ACT_TRIPLE_JUMP_LAND_STOP] = true,
    [ACT_BACKFLIP_LAND] = true,
    [ACT_BACKFLIP_LAND_STOP] = true,
    [ACT_TWIRLING] = true,
    [ACT_END_WAVING_CUTSCENE] = true,
}

local MikuEyeSadActs = {
    [ACT_PANTING] = true,
    [ACT_DEATH_EXIT_LAND] = true,
    [ACT_COUGHING] = true,
    [ACT_SHIVERING] = true,
}

local function dynameyes(m)
    if mikueyes then
        local charNum = _G.charSelect.character_get_current_number()
        if charNum == CT_MIKU or charNum == CT_TETO or charNum == CT_NERU then
            if MikuEyeSadActs[m.action] then
                m.marioBodyState.eyeState = 11
            end

            if MikuEyeHurtActs[m.action] or (MikuEyeHurtActsConditional[m.action] and m.actionArg > 0) then
                m.marioBodyState.eyeState = 10
            end

            if MikuEyeHappyActs[m.action] then
                m.marioBodyState.eyeState = 9
            end

            if m.marioBodyState.handState == MARIO_HAND_PEACE_SIGN then
                m.marioBodyState.eyeState = 9
            end

            if (m.marioBodyState.eyeState ~= 8 and m.marioBodyState.eyeState ~= 10) then
                if (abs_angle_diff(m.faceAngle.y, m.intendedYaw) > 500 and m.action & ACT_FLAG_AIR == 0) then
                    if (m.action & ACT_FLAG_SWIMMING_OR_FLYING == 0) then
                        if s16(m.intendedYaw - m.faceAngle.y) > 0 then
                            m.marioBodyState.eyeState = 5
                        else
                            m.marioBodyState.eyeState = 4
                        end
                        if m.vel.y > 10 then
                            m.marioBodyState.eyeState = 6
                        end
                        
                        if m.action ~= ACT_IDLE then
                            if m.vel.y < -25 then
                                m.marioBodyState.eyeState = 7
                            end
                        end
                    else
                        if s16(m.intendedYaw - m.faceAngle.y) > 0 then
                            m.marioBodyState.eyeState = 4
                        else
                            m.marioBodyState.eyeState = 5
                        end
                    end
                else
                    if m.vel.y > 10 then
                        m.marioBodyState.eyeState = 6
                    end
                end

                if m.action ~= ACT_JUMBO_STAR_CUTSCENE and m.action ~= ACT_IDLE then
                    if m.vel.y < -25 then
                        m.marioBodyState.eyeState = 7
                    end
                end

                if m.action ~= ACT_END_PEACH_CUTSCENE then
                    if m.action & ACT_FLAG_INVULNERABLE == 0 and m.action ~= ACT_TWIRLING and m.action ~= ACT_FLYING and (m.action & ACT_GROUP_AIRBORNE ~= 0 or m.action & ACT_FLAG_AIR ~= 0) then
                        if m.peakHeight - m.pos.y > 1150 and m.pos.y > m.waterLevel then
                            m.marioBodyState.eyeState = 10
                        end
                    end
                end
            end
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, dynameyes)

local function mikueyesToggle(index, value)
    mikueyes = value
    mod_storage_save_bool("mikueyes", value)
end

hook_mod_menu_checkbox("Dynamic Eyes", mod_storage_load_bool("mikueyes"), mikueyesToggle)

-- Original Dynamic Eyes Code by Radishcatish
-- Revised Dynamic Eyes Code by Baconator
