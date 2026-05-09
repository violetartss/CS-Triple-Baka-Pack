local colObjLists = { OBJ_LIST_GENACTOR, OBJ_LIST_PUSHABLE, OBJ_LIST_SURFACE, OBJ_LIST_DESTRUCTIVE }

local bhvBlacklist = {
    [id_bhvBowser] = true,
    [id_bhvDoor] = true,
    [id_bhvDoorWarp] = true,
    [id_bhvStarDoor] = true,
    [id_bhvUnlockDoorStar] = true,
    [id_bhvToadMessage] = true,
    [id_bhvFireSpitter] = true,
    [id_bhvExplosion] = true
}

---@param o Object
---@param o2 Object
local function attack_bounce(o, o2)
    o2.oVelY = 15.0
    play_sound(SOUND_ACTION_BONK, o2.header.gfx.cameraToObject)
end

---@param o Object
---@param o2 Object
local function attack_bully(o, o2)
    o2.oBullyLastNetworkPlayerIndex = o.globalPlayerIndex
    o2.oMoveAngleYaw = o.oMoveAngleYaw
    o2.oForwardVel = 30.0

    o2.oInteractStatus = o2.oInteractStatus | ATTACK_FAST_ATTACK | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED
end
---@param o Object
---@param o2 Object
local function attack_bully_2(o, o2)
    o2.oBullyLastNetworkPlayerIndex = o.globalPlayerIndex
    o2.oMoveAngleYaw = o.oMoveAngleYaw
    o2.oForwardVel = 50.0
    o2.oVelY = 30.0

    o2.oInteractStatus = o2.oInteractStatus | ATTACK_FAST_ATTACK | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED
end

---@param o Object
---@param o2 Object
local function attack_mrblizzard(o, o2)
    if o2.prevObj then
        o2.prevObj.oAction = 2
        o2.prevObj = nil
        o2.oMrBlizzardHeldObj = nil
    end
    o2.oAction = MR_BLIZZARD_ACT_DEATH
end

---@param o Object
---@param o2 Object
local function attack_bullet_bill(o, o2)
    spawn_mist_particles_with_sound(SOUND_GENERAL2_BOBOMB_EXPLOSION)
    o2.oAction = 4
    o2.oTimer = 0
end

---@param o Object
---@param o2 Object
local function attack_chuckya(o, o2)
    o2.oAction = 2
    o2.oVelY = 30
    o2.oMoveAngleYaw = o.oMoveAngleYaw
    o2.oForwardVel = 25
end

---@param o Object
---@param o2 Object
local function attack_whomp(o, o2)
    if o2.oBehParams2ndByte ~= 0 then return end
    o2.oNumLootCoins = 5
    obj_spawn_loot_yellow_coins(o2, 5, 20.0)
    o2.oAction = 8
end

---@param o Object
---@param o2 Object
local function attack_kingbobomb(o, o2)
    if o2.oFlags & OBJ_FLAG_HOLDABLE ~= 0 and o2.oAction ~= 8 then
        o2.oVelY = 30
        o2.oForwardVel = 30
        o2.oMoveAngleYaw = o.oMoveAngleYaw
        o2.oMoveFlags = 0
        o2.oAction = 4
    end
end


bhvMediumAttacks = {
    [id_bhvSmallBully] = attack_bully,
    [id_bhvBigBully] = attack_bully,
    [id_bhvBigBullyWithMinions] = attack_bully,
    [id_bhvSmallChillBully] = attack_bully,
    [id_bhvBigChillBully] = attack_bully,
    [id_bhvBulletBill] = attack_bullet_bill,
    [id_bhvChuckya] = attack_chuckya,
    [id_bhvMrBlizzard] = attack_mrblizzard,
    [id_bhvSmallWhomp] = attack_bounce,
}

bhvHeavyAttacks = {
    [id_bhvSmallBully] = attack_bully_2,
    [id_bhvBigBully] = attack_bully_2,
    [id_bhvBigBullyWithMinions] = attack_bully_2,
    [id_bhvSmallChillBully] = attack_bully_2,
    [id_bhvBigChillBully] = attack_bully_2,
    [id_bhvBulletBill] = attack_bullet_bill,
    [id_bhvChuckya] = attack_chuckya,
    [id_bhvMrBlizzard] = attack_mrblizzard,
    [id_bhvSmallWhomp] = attack_whomp,
    [id_bhvKingBobomb] = attack_kingbobomb,
}

---@class Beam
---@field startPos Vec3f
---@field dir Vec3f
---@field length number
---@field radius number

---@param o Object
---@param beam Beam
local function obj_is_on_beam(o, beam)
    local objPos = { x = o.oPosX, y = o.oPosY, z = o.oPosZ }
    local projection = gVec3fZero()
    -- align positions as if beam root is origin
    vec3f_sub(objPos, beam.startPos)
    vec3f_project(projection, objPos, beam.dir)
    -- clamp
    if vec3f_dot(projection, beam.dir) < 0 then return end
    if vec3f_length(projection) > beam.length then
        vec3f_copy(projection, beam.dir)
        vec3f_mul(projection, beam.length)
    end

    local lateralDist = math.sqrt((objPos.x - projection.x) ^ 2 + (objPos.z - projection.z) ^ 2)
    if lateralDist < beam.radius + o.hitboxRadius and
        objPos.y - o.hitboxDownOffset < projection.y + beam.radius and
        objPos.y - o.hitboxDownOffset > projection.y - beam.radius - o.hitboxHeight then
        return true
    end
end

---@param o Object
---@param beam Beam
---@param spAttacksList table<BehaviorId,function>
function obj_process_beam_attacks(o, beam, spAttacksList)
    -- players
    local m = nearest_mario_state_to_object(o)
    if m and m.playerIndex == 0 and m.marioObj.globalPlayerIndex ~= o.globalPlayerIndex
        and m.action & (ACT_FLAG_INVULNERABLE | ACT_FLAG_INTANGIBLE) == 0 and m.invincTimer == 0
        and obj_is_on_beam(m.marioObj, beam) then
        if spAttacksList[id_bhvMario] then
            spAttacksList[id_bhvMario](o, m)
        else
            take_damage_and_knock_back(m, o)
        end
    end
    -- other objects
    for i, list in ipairs(colObjLists) do
        local o2 = obj_get_first(list)
        while o2 do
            if o ~= o2 and o2.oInteractStatus & INT_STATUS_INTERACTED == 0 and o.oIntangibleTimer == 0 and obj_is_on_beam(o2, beam) then
                local bhv = get_id_from_behavior(o2.behavior)
                if not bhvBlacklist[bhv] then
                    if spAttacksList[bhv] then
                        spAttacksList[bhv](o, o2)
                    else
                        o2.oInteractStatus = o2.oInteractStatus | ATTACK_FAST_ATTACK | INT_STATUS_WAS_ATTACKED |
                            INT_STATUS_INTERACTED
                    end
                end
            end
            o2 = obj_get_next(o2)
        end
    end
end

-- BEHAVIOR

---@param o Object
local function bhv_miku_beam_init(o)
    o.oFlags             = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    o.hitboxDownOffset   = 0
    o.hitboxRadius       = 0
    o.hitboxHeight       = 0
    o.oHealth            = 0
    o.oInteractType      = 0
    o.oNumLootCoins      = 0
    o.oDamageOrCoinValue = 3

    o.oGravity           = 0.0
    o.oDragStrength      = 1.0

    obj_scale(o, 0.01)
    network_init_object(o, true, {})
end
---@param o Object
local function bhv_miku_beam_loop(o)
    local m = gMarioStates[network_local_index_from_global(o.globalPlayerIndex)]
    local p = gPlayerSyncTable[m.playerIndex]

    local yaw = m.faceAngle.y + p.beamYaw
    local pitch = p.beamPitch
    local dir = { x = sins(yaw) * coss(pitch), y = -sins(pitch), z = coss(yaw) * coss(pitch) }
    --local dist = 50

    o.oPosX = m.pos.x       -- + dir.x * dist
    o.oPosY = m.pos.y + 120 -- + dir.y * dist
    o.oPosZ = m.pos.z       -- + dir.z * dist

    o.oFaceAngleYaw = yaw
    o.oFaceAnglePitch = pitch

    if o.oIntangibleTimer == 0 then
        ---@type Beam
        local beam = {
            startPos = { x = o.oPosX, y = o.oPosY, z = o.oPosZ },
            dir = dir,
            length = 1600,
            radius = 60,
        }

        obj_process_beam_attacks(o, beam, bhvHeavyAttacks)

        if o.oTimer % 2 == 0 then
            local hit = collision_find_surface_on_ray(o.oPosX, o.oPosY, o.oPosZ,
                dir.x * beam.length, dir.y * beam.length, dir.z * beam.length)
            if hit.surface then
                local particle = spawn_non_sync_object(id_bhvSmoke, E_MODEL_SMOKE, hit.hitPos.x, hit.hitPos.y,
                    hit.hitPos.z, nil)
                particle.oPosX = particle.oPosX + math.random(-40, 40)
                particle.oPosZ = particle.oPosZ + math.random(-40, 40)
            end
        end
    end

    if m.action ~= ACT_EMOTING then o.oTimer = 140 end

    if o.oTimer <= 3 then
        local scale = math.lerp(0.01, 1.0, o.oTimer / 3.0)
        obj_scale_xyz(o, scale, scale, 1.0)
    elseif o.oTimer > 140 then
        local scale = math.lerp(1.0, 0.01, (o.oTimer - 140) / 10.0)
        obj_scale_xyz(o, scale, scale, 1.0)
    end

    smlua_anim_util_set_animation(o, 'obj_mikubeam')

    if o.oTimer == 5 then cur_obj_become_tangible() end
    if o.oTimer == 140 then cur_obj_become_intangible() end
    if o.oTimer > 150 then obj_mark_for_deletion(o) end
end

id_bhvMikuBeam = hook_behavior(nil, OBJ_LIST_GENACTOR, false, bhv_miku_beam_init, bhv_miku_beam_loop, "bhvMikuBeam")


-- ANIMATION

smlua_anim_util_register_animation('obj_mikubeam', 0, 0, 0, 0, 30, {
    0, 0, 0, 0, 0, 0, 2185, 4369, 6554,
    8738, 10923, 13107, 15292, 17476, 19661, 21845, 24030, 26214,
    28399, 30583, 32768, 34952, 37137, 39321, 41506, 43690, 45875,
    48059, 50243, 52428, 54612, 56797, 58982, 61166, 63350, 0,
    0, 0, 0, 63350, 61166, 58981, 56797, 54612, 52428,
    50243, 48059, 45874, 43690, 41505, 39321, 37136, 34952, 32767,
    30583, 28398, 26214, 24029, 21845, 19660, 17476, 15292, 13107,
    10923, 8738, 6553, 4369, 2185, 65535,
}, {
    1, 0, 1, 1, 1, 2, 1, 3, 1,
    4, 31, 5, 1, 36, 1, 37, 31, 38,
})
