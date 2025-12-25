-- name: [CS] \\#00DFFF\\Triple\\#FF2A44\\ Baka\\#FFBE16\\ Pack
-- description: The Cheerful Vocaloid, \\#00DFFF\\Hatsune Miku\\#FFFFFF\\, her eager but also mischievous friend, \\#FF2A44\\Kasane Teto\\#FFFFFF\\, and the most subborn of the trio, \\#FFBE16\\Akita Neru\\#FFFFFF\\, all arrive in the low poly world of the Mushroom Kingdom, will the singing trio be able to grab all the stars and save the Princess from the Koopa Clan leader, Bowser?\n\n\\\#FCBA03\\WARNING: This mod might have a person who has Blue Hair, Blue Tie, hiding in your Wi-Fi!\n\n\\\#FFFFFF\\Made by VioletArts and Chalz\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

-- Replace Mod Name with your Character/Pack name.
local TEXT_MOD_NAME = "Triple Baka Pack"

-- Stops mod from loading if Character Select isn't on, Does not need to be touched
if not _G.charSelectExists then
    djui_popup_create(
        "\\#ffffdc\\\n" ..
        TEXT_MOD_NAME ..
        "\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!",
        6)
    return 0
end

local TEX_MIKU_ICON = get_texture_info("miku_violet_icon")
local TEX_TETO_ICON = get_texture_info("teto_violet_icon")
local TEX_NERU_ICON = get_texture_info("neru_violet_icon")

local TEX_MIKU_GRAFFITI = get_texture_info("miku_logo")
local TEX_TETO_GRAFFITI = get_texture_info("teto_logo")
local TEX_NERU_GRAFFITI = get_texture_info("neru_logo")

local E_SOUND_MIKU = audio_stream_load("MikuCS.ogg")
local E_SOUND_TETO = audio_stream_load("TetoCS.ogg")
local E_SOUND_NERU = audio_stream_load("NeruCS.ogg")

local VOICETABLE_MIKU = {
    [CHAR_SOUND_OKEY_DOKEY] = 'MikuOkieDokie.ogg',
    [CHAR_SOUND_ATTACKED] = 'MikuAttacked.ogg',
    [CHAR_SOUND_COUGHING3] = 'MikuCough.ogg',
    [CHAR_SOUND_DOH] = 'MikuDoh.ogg',
    [CHAR_SOUND_DROWNING] = 'MikuDrown.ogg',
    [CHAR_SOUND_DYING] = 'MikuDead.ogg',
    [CHAR_SOUND_EEUH] = 'MikuEeuh.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'MikuWah.ogg',
    [CHAR_SOUND_HAHA] = 'MikuHaha.ogg',
    [CHAR_SOUND_HAHA_2] = 'MikuHaha.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'MikuSugoi.ogg',
    [CHAR_SOUND_HOOHOO] = 'MikuHoohoo.ogg',
    [CHAR_SOUND_HRMM] = 'MikuGrab.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'MikuTired.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'MikuLetsDoThis.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'MikuOhNo.ogg',
    [CHAR_SOUND_ON_FIRE] = 'MikuBurning.ogg',
    [CHAR_SOUND_OOOF] = 'MikuOof.ogg',
    [CHAR_SOUND_OOOF2] = 'MikuOof.ogg',
    [CHAR_SOUND_PANTING] = 'MikuPanting.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'MikuPanting.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'MikuHoo.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'MikuWah.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'MikuYah.ogg',
    [CHAR_SOUND_SNORING1] = 'MikuSnore1.ogg',
    [CHAR_SOUND_SNORING2] = 'MikuSnore2.ogg',
    [CHAR_SOUND_SNORING3] = 'MikuSleep.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'MikuBowser.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'MikuBoing.ogg',
    [CHAR_SOUND_UH] = 'MikuUh.ogg',
    [CHAR_SOUND_UH2] = 'MikuUh.ogg',
    [CHAR_SOUND_UH2_2] = 'MikuUh.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'MikuYell.ogg',
    [CHAR_SOUND_WHOA] = 'MikuWoah.ogg',
    [CHAR_SOUND_YAHOO] = 'MikuYahoo.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = { 'MikuYahoo.ogg', 'MikuWaha.ogg', 'MikuYippee.ogg' },
    [CHAR_SOUND_YAH_WAH_HOO] = { 'MikuYah.ogg', 'MikuWah.ogg', 'MikuHoo.ogg' },
    [CHAR_SOUND_YAWNING] = 'MikuYawn.ogg',
}

local VOICETABLE_TETO = {
    [CHAR_SOUND_OKEY_DOKEY] = 'TetoOkieDokie.ogg',
    [CHAR_SOUND_ATTACKED] = 'TetoAttacked.ogg',
    [CHAR_SOUND_COUGHING3] = 'TetoCough.ogg',
    [CHAR_SOUND_DOH] = 'TetoDoh.ogg',
    [CHAR_SOUND_DROWNING] = 'TetoDrown.ogg',
    [CHAR_SOUND_DYING] = 'TetoDead.ogg',
    [CHAR_SOUND_EEUH] = 'TetoEeuh.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'TetoWah.ogg',
    [CHAR_SOUND_HAHA] = 'TetoHaha.ogg',
    [CHAR_SOUND_HAHA_2] = 'TetoHaha.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'TetoHereWeGo.ogg',
    [CHAR_SOUND_HOOHOO] = 'TetoHooHoo.ogg',
    [CHAR_SOUND_HRMM] = 'TetoGrab.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'TetoTired.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'TetoLetsDoThis.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'TetoOhNo.ogg',
    [CHAR_SOUND_ON_FIRE] = 'TetoBurning.ogg',
    [CHAR_SOUND_OOOF] = 'TetoOof.ogg',
    [CHAR_SOUND_OOOF2] = 'TetoOof.ogg',
    [CHAR_SOUND_PANTING] = 'TetoPanting.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'TetoPanting.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'TetoHoo.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'TetoWah.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'TetoYah.ogg',
    [CHAR_SOUND_SNORING1] = 'TetoSnore1.ogg',
    [CHAR_SOUND_SNORING2] = 'TetoSnore2.ogg',
    [CHAR_SOUND_SNORING3] = 'TetoSleep.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'TetoBowser.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'TetoBoing.ogg',
    [CHAR_SOUND_UH] = 'TetoUh.ogg',
    [CHAR_SOUND_UH2] = 'TetoUh.ogg',
    [CHAR_SOUND_UH2_2] = 'TetoUh.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'TetoYell.ogg',
    [CHAR_SOUND_WHOA] = 'TetoWoah.ogg',
    [CHAR_SOUND_YAHOO] = 'TetoYahoo.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = { 'TetoYahoo.ogg', 'TetoWaha.ogg', 'TetoYippee.ogg' },
    [CHAR_SOUND_YAH_WAH_HOO] = { 'TetoYah.ogg', 'TetoWah.ogg', 'TetoHoo.ogg' },
    [CHAR_SOUND_YAWNING] = 'TetoYawn.ogg',
}

local VOICETABLE_NERU = {
    [CHAR_SOUND_OKEY_DOKEY] = 'NeruOkieDokie.ogg',
    [CHAR_SOUND_ATTACKED] = 'NeruAttacked.ogg',
    [CHAR_SOUND_COUGHING3] = 'NeruCough.ogg',
    [CHAR_SOUND_DOH] = 'NeruDoh.ogg',
    [CHAR_SOUND_DROWNING] = 'NeruDrown.ogg',
    [CHAR_SOUND_DYING] = 'NeruDead.ogg',
    [CHAR_SOUND_EEUH] = 'NeruEeuh.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'NeruWah.ogg',
    [CHAR_SOUND_HAHA] = 'NeruHaha.ogg',
    [CHAR_SOUND_HAHA_2] = 'NeruHaha.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'NeruHereWeGo.ogg',
    [CHAR_SOUND_HOOHOO] = 'NeruHooHoo.ogg',
    [CHAR_SOUND_HRMM] = 'NeruGrab.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'NeruTired.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'NeruLetsDoThis.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'NeruOhNo.ogg',
    [CHAR_SOUND_ON_FIRE] = 'NeruBurning.ogg',
    [CHAR_SOUND_OOOF] = 'NeruOof.ogg',
    [CHAR_SOUND_OOOF2] = 'NeruOof.ogg',
    [CHAR_SOUND_PANTING] = 'NeruPanting.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'NeruPanting.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'NeruHoo.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'NeruWah.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'NeruYah.ogg',
    [CHAR_SOUND_SNORING1] = 'NeruSnore1.ogg',
    [CHAR_SOUND_SNORING2] = 'NeruSnore2.ogg',
    [CHAR_SOUND_SNORING3] = 'NeruSnore3.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'NeruBowser.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'NeruBoing.ogg',
    [CHAR_SOUND_UH] = 'NeruUh.ogg',
    [CHAR_SOUND_UH2] = 'NeruUh.ogg',
    [CHAR_SOUND_UH2_2] = 'NeruUh.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'NeruYell.ogg',
    [CHAR_SOUND_WHOA] = 'NeruWoah.ogg',
    [CHAR_SOUND_YAHOO] = 'NeruYahoo.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = { 'NeruYahoo.ogg', 'NeruWaha.ogg', 'NeruYippee.ogg' },
    [CHAR_SOUND_YAH_WAH_HOO] = { 'NeruYah.ogg', 'NeruWah.ogg', 'NeruHoo.ogg' },
    [CHAR_SOUND_YAWNING] = 'NeruYawn.ogg',
}

local MIKU_CAPMODELS = {
    normal = smlua_model_util_get_id("miku_violet_cap_geo"),
    wing = smlua_model_util_get_id("miku_violet_cap_wing_geo"),
    metal = smlua_model_util_get_id("miku_violet_cap_metal_geo"),
    metalWing = smlua_model_util_get_id("miku_violet_cap_metal_wing_geo"),
}

local TETO_CAPMODELS = {
    normal = smlua_model_util_get_id("teto_violet_cap_geo"),
    wing = smlua_model_util_get_id("teto_violet_cap_wing_geo"),
    metal = smlua_model_util_get_id("teto_violet_cap_metal_geo"),
    metalWing = smlua_model_util_get_id("teto_violet_cap_metal_wing_geo"),
}

local NERU_CAPMODELS = {
    normal = smlua_model_util_get_id("neru_violet_cap_geo"),
    wing = smlua_model_util_get_id("neru_violet_cap_wing_geo"),
    metal = smlua_model_util_get_id("neru_violet_cap_metal_geo"),
    metalWing = smlua_model_util_get_id("neru_violet_cap_metal_wing_geo"),
}

local HEALTH_METER_MIKU = {
    label = {
        left = get_texture_info("MikuLeft"),
        right = get_texture_info("MikuRight"),
    },
    pie = {
        [1] = get_texture_info("Miku-1"),
        [2] = get_texture_info("Miku-2"),
        [3] = get_texture_info("Miku-3"),
        [4] = get_texture_info("Miku-4"),
        [5] = get_texture_info("Miku-5"),
        [6] = get_texture_info("Miku-6"),
        [7] = get_texture_info("Miku-7"),
        [8] = get_texture_info("Miku-8"),
    }
}

local HEALTH_METER_TETO = {
    label = {
        left = get_texture_info("TetoLeft"),
        right = get_texture_info("TetoRight"),
    },
    pie = {
        [1] = get_texture_info("Miku-1"),
        [2] = get_texture_info("Miku-2"),
        [3] = get_texture_info("Miku-3"),
        [4] = get_texture_info("Miku-4"),
        [5] = get_texture_info("Miku-5"),
        [6] = get_texture_info("Miku-6"),
        [7] = get_texture_info("Miku-7"),
        [8] = get_texture_info("Miku-8"),
    }
}


local HANDTABLE_MIKU = {
    [_G.charSelect.CS_ANIM_MENU] = MARIO_HAND_PEACE_SIGN,
}
local ANIMTABLE_MIKU = {
    [CHAR_ANIM_STAR_DANCE] = 'MikuStarDance',
    [CHAR_ANIM_RETURN_FROM_STAR_DANCE] = 'MikuStarDanceEnd',
    [CHAR_ANIM_WATER_STAR_DANCE] = 'MikuStarDanceWater',
    [CHAR_ANIM_RETURN_FROM_WATER_STAR_DANCE] = 'MikuStarDanceWaterEnd',
    [CHAR_ANIM_CREDITS_PEACE_SIGN] = 'MikuCreditsPeace',
    [CHAR_ANIM_CREDITS_TAKE_OFF_CAP] = 'MikuCreditsHat1',
    [CHAR_ANIM_CREDITS_LOOK_UP] = 'MikuCreditsHat2',
    [_G.charSelect.CS_ANIM_MENU] = 'MikuCS',
}


local HANDTABLE_TETO = {

}
local EYETABLE_TETO = {
    [_G.charSelect.CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT,
}
local ANIMTABLE_TETO = {
    [CHAR_ANIM_CREDITS_TAKE_OFF_CAP] = 'MikuCreditsHat1',
    [CHAR_ANIM_CREDITS_LOOK_UP] = 'MikuCreditsHat2',
    [_G.charSelect.CS_ANIM_MENU] = 'TetoCS',
}


local HANDTABLE_NERU = {
    [_G.charSelect.CS_ANIM_MENU] = MARIO_HAND_PEACE_SIGN,
}
local EYETABLE_NERU = {
    [_G.charSelect.CS_ANIM_MENU] = MARIO_EYES_LOOK_DOWN,
}
local ANIMTABLE_NERU = {
    [CHAR_ANIM_CREDITS_TAKE_OFF_CAP] = 'MikuCreditsHat1',
    [CHAR_ANIM_CREDITS_LOOK_UP] = 'MikuCreditsHat2',
    [_G.charSelect.CS_ANIM_MENU] = 'NeruCS',
}

------------------------
-- COSTUME INFO BELOW --
------------------------

local COSTUMETABLE_MIKU = {
    {
        name = "Hatsune Miku",
        model = smlua_model_util_get_id("miku_violet_geo"),
        palettes = {
            {
                name = "Original",
                [PANTS] = "2A2A2A",
                [SHIRT] = "B1B1B1",
                [GLOVES] = "2A2A2A",
                [SHOES] = "2A2A2A",
                [HAIR] = "00DFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "40F8FF",
                [EMBLEM] = "FF00C2"
            },
            {
                name = "Sakura",
                [PANTS] = "FFA6B9",
                [SHIRT] = "FFFFFF",
                [GLOVES] = "FF819A",
                [SHOES] = "FFA6B9",
                [HAIR] = "FFA6B9",
                [SKIN] = "FFC8A7",
                [CAP] = "FF819A",
                [EMBLEM] = "FFFFFF"
            },
            {
                name = "Greenku",
                [PANTS] = "181818",
                [SHIRT] = "606060",
                [GLOVES] = "181818",
                [SHOES] = "181818",
                [HAIR] = "00CC7F",
                [SKIN] = "FEBE8E",
                [CAP] = "33AA69",
                [EMBLEM] = "FF4F5C"
            },
            {
                name = "Snow",
                [PANTS] = "FFFFFF",
                [SHIRT] = "FFFFFF",
                [GLOVES] = "A09EBC",
                [SHOES] = "A09EBC",
                [HAIR] = "FFFFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "2363B6",
                [EMBLEM] = "2363B6"
            },
            {
                name     = "Kagamine",
                [PANTS]  = "4F5656",
                [SHIRT]  = "FFFFFF",
                [GLOVES] = "4F5656",
                [SHOES]  = "4F5656",
                [HAIR]   = "FAD92C",
                [SKIN]   = "FFC8A7",
                [CAP]    = "FFD701",
                [EMBLEM] = "FFD701"
            },
            {
                name = "Classic",
                [PANTS] = "233139",
                [SHIRT] = "BBBFCA",
                [GLOVES] = "233139",
                [SHOES] = "233139",
                [HAIR] = "32BCC6",
                [SKIN] = "FFBD97",
                [CAP] = "32BCC6",
                [EMBLEM] = "FF07A1"
            }
        }
    },
    {
        name = "Mario Miku",
        model = smlua_model_util_get_id("mariomiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "0000FF",
                [SHIRT] = "FF0000",
                [GLOVES] = "FFFFFF",
                [SHOES] = "721C0E",
                [HAIR] = "00DFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "FF0000",
                [EMBLEM] = "FF0000"
            }
        }
    },
    {
        name = "Mesmerizer Miku",
        model = smlua_model_util_get_id("mesmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "1680B8",
                [SHIRT] = "1680B8",
                [GLOVES] = "FFFFFF",
                [SHOES] = "F0214D",
                [HAIR] = "00DFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "1680B8",
                [EMBLEM] = "FFEF00"
            }
        }
    },
    {
        name = "Triple Baka Miku",
        model = smlua_model_util_get_id("tbmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "42454A",
                [SHIRT] = "9A9A9A",
                [GLOVES] = "42454A",
                [SHOES] = "42454A",
                [HAIR] = "28D1D8",
                [SKIN] = "FAF2DD",
                [CAP] = "28D1D8",
                [EMBLEM] = "EF109D"
            }
        }
    },
    {
        name = "Sonic Miku",
        model = smlua_model_util_get_id("sonicmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "3A6BFF",
                [SHIRT] = "3A6BFF",
                [GLOVES] = "FFFFFF",
                [SHOES] = "FF0000",
                [HAIR] = "00DFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "3A6BFF",
                [EMBLEM] = "40F8FF"
            }
        }
    },
    {
        name = "World Is Mine Miku",
        model = smlua_model_util_get_id("worldmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "2A2A2A",
                [SHIRT] = "FFFFFF",
                [GLOVES] = "2A2A2A",
                [SHOES] = "FF0000",
                [HAIR] = "00DFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "6D00B9",
                [EMBLEM] = "FFEF00"
            }
        }
    },
    {
        name = "Brazilian Miku",
        model = smlua_model_util_get_id("brazilmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "6295AB",
                [SHIRT] = "E3CC4E",
                [GLOVES] = "FFFFFF",
                [SHOES] = "464998",
                [HAIR] = "52B1B5",
                [SKIN] = "D99462",
                [CAP] = "E3CC4E",
                [EMBLEM] = "2F7541"
            }
        }
    },
    {
        name = "Magical Cure Love Shot Miku",
        model = smlua_model_util_get_id("mclsmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "DB5C90",
                [SHIRT] = "FFFFFF",
                [GLOVES] = "FFFFFF",
                [SHOES] = "FBB05A",
                [HAIR] = "00DFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "FFFFFF",
                [EMBLEM] = "F1A7C9"
            }
        }
    },
    {
        name = "Static Miku",
        model = smlua_model_util_get_id("staticmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "000000",
                [SHIRT] = "2D00DB",
                [GLOVES] = "FFFFFF",
                [SHOES] = "000000",
                [HAIR] = "02FFFD",
                [SKIN] = "FE9752",
                [CAP] = "000000",
                [EMBLEM] = "F8E323"
            }
        }
    },
    {
        name = "Hatsune Miku (Classic)",
        model = smlua_model_util_get_id("classicmiku_violet_geo"),
        palettes = {
            {
                [PANTS] = "233139",
                [SHIRT] = "BBBFCA",
                [GLOVES] = "233139",
                [SHOES] = "233139",
                [HAIR] = "32BCC6",
                [SKIN] = "FFBD97",
                [CAP] = "32BCC6",
                [EMBLEM] = "32BCC6"
            }
        },
        defaultAnims = true
    },
}

local COSTUMETABLE_NERU = {
    {
        name = "Akita Neru",
        model = smlua_model_util_get_id("neru_violet_geo"),
        palettes = {
            {
                name = "Original",
                [PANTS] = "2A2A2A",
                [SHIRT] = "555555",
                [GLOVES] = "2A2A2A",
                [SHOES] = "2A2A2A",
                [HAIR] = "FFBE16",
                [SKIN] = "FFC8A7",
                [CAP] = "FFBF2D",
                [EMBLEM] = "424FFF"
            },
            {
                name = "Fake Miku",
                [PANTS] = "2A2A2A",
                [SHIRT] = "B1B1B1",
                [GLOVES] = "2A2A2A",
                [SHOES] = "2A2A2A",
                [HAIR] = "00DFFF",
                [SKIN] = "FFC8A7",
                [CAP] = "40F8FF",
                [EMBLEM] = "FF00C2"
            },
            {
                name = "Luka",
                [PANTS] = "2E3139",
                [SHIRT] = "5E5E6A",
                [GLOVES] = "F2C666",
                [SHOES] = "2E3139",
                [HAIR] = "EA8B9E",
                [SKIN] = "FFC8A7",
                [CAP] = "F2C666",
                [EMBLEM] = "4A64C0"
            },
            {
                name = "KAITO",
                [PANTS] = "2E3139",
                [SHIRT] = "FFFFFF",
                [GLOVES] = "2E3139",
                [SHOES] = "2E3139",
                [HAIR] = "4458AF",
                [SKIN] = "FFC8A7",
                [CAP] = "5F70CF",
                [EMBLEM] = "FAF03A"
            },
            {
                name = "Yowane Haku",
                [PANTS] = "2F2E33",
                [SHIRT] = "B6B4BE",
                [GLOVES] = "2F2E33",
                [SHOES] = "2F2E33",
                [HAIR] = "D6D6D8",
                [SKIN] = "FFC8A7",
                [CAP] = "6C5FF1",
                [EMBLEM] = "6C5FF1"
            },
            {
                name = "Classic",
                [PANTS] = "353535",
                [SHIRT] = "838383",
                [GLOVES] = "353535",
                [SHOES] = "353535",
                [HAIR] = "FFBF2D",
                [SKIN] = "FFBD97",
                [CAP] = "FFBF2D",
                [EMBLEM] = "4547FF"
            }
        }
    },
    {
        name = "Wario Neru",
        model = smlua_model_util_get_id("warioneru_violet_geo"),
        palettes = {
            {
                [PANTS] = "7B00BD",
                [SHIRT] = "FFC53F",
                [GLOVES] = "FFFFFF",
                [SHOES] = "0E721C",
                [HAIR] = "FFBE16",
                [SKIN] = "FFC8A7",
                [CAP] = "FFC53F",
                [EMBLEM] = "0000FF"
            }
        }
    },
    {
        name = "Mesmerizer Neru",
        model = smlua_model_util_get_id("mesneru_violet_geo"),
        palettes = {
            {
                [PANTS] = "E9DB09",
                [SHIRT] = "E9DB09",
                [GLOVES] = "FFFFFF",
                [SHOES] = "191A1E",
                [HAIR] = "FFBE16",
                [SKIN] = "FFC8A7",
                [CAP] = "FFFFFF",
                [EMBLEM] = "191A1E"
            }
        }
    },
    {
        name = "Triple Baka Neru",
        model = smlua_model_util_get_id("tbneru_violet_geo"),
        palettes = {
            {
                [PANTS] = "42454A",
                [SHIRT] = "9A9A9A",
                [GLOVES] = "42454A",
                [SHOES] = "42454A",
                [HAIR] = "F2D651",
                [SKIN] = "FAF2DD",
                [CAP] = "F2D651",
                [EMBLEM] = "4E4C9F"
            }
        }
    },
    {
        name = "Silver Neru",
        model = smlua_model_util_get_id("silverneru_violet_geo"),
        palettes = {
            {
                [PANTS] = "CACACA",
                [SHIRT] = "CACACA",
                [GLOVES] = "FFFFFF",
                [SHOES] = "0D3653",
                [HAIR] = "FFBE16",
                [SKIN] = "FFC8A7",
                [CAP] = "CACACA",
                [EMBLEM] = "FFDD00"
            }
        }
    },
    {
        name = "Flop Era Neru",
        model = smlua_model_util_get_id("flopneru_violet_geo"),
        palettes = {
            {
                [PANTS] = "C48875",
                [SHIRT] = "534748",
                [GLOVES] = "534748",
                [SHOES] = "D9A4C4",
                [HAIR] = "FFBE16",
                [SKIN] = "FFC8A7",
                [CAP] = "D9A4C4",
                [EMBLEM] = "D9A4C4"
            }
        }
    },
    {
        name = "Akita Neru (Classic)",
        model = smlua_model_util_get_id("classicneru_violet_geo"),
        palettes = {
            {
                [PANTS] = "353535",
                [SHIRT] = "838383",
                [GLOVES] = "353535",
                [SHOES] = "353535",
                [HAIR] = "FFBF2D",
                [SKIN] = "FFBD97",
                [CAP] = "FFBF2D",
                [EMBLEM] = "FFBF2D"
            }
        },
        defaultAnims = true
    },
}

local COSTUMETABLE_TETO = {
    {
        name = "Kasane Teto",
        model = smlua_model_util_get_id("teto_violet_geo"),
        palettes = {
            {
                name = "Original",
                [PANTS] = "3F4157",
                [SHIRT] = "3F4157",
                [GLOVES] = "3F4157",
                [SHOES] = "2A2A2A",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "FF4141",
                [EMBLEM] = "7C2C50"
            },
            {
                name = "Pearto",
                [PANTS] = "7B1D00",
                [SHIRT] = "A00029",
                [GLOVES] = "3F4157",
                [SHOES] = "7B1D00",
                [HAIR] = "94BB00",
                [SKIN] = "FFC8A7",
                [CAP] = "94BB00",
                [EMBLEM] = "7B1D00"
            },
            {
                name = "Igaku",
                [PANTS] = "476289",
                [SHIRT] = "476289",
                [GLOVES] = "476289",
                [SHOES] = "785A42",
                [HAIR] = "B14745",
                [SKIN] = "FFC8A7",
                [CAP] = "476289",
                [EMBLEM] = "476289"
            },
            {
                name = "Gumi",
                [PANTS] = "90F076",
                [SHIRT] = "FF975C",
                [GLOVES] = "73D871",
                [SHOES] = "FF975C",
                [HAIR] = "73D871",
                [SKIN] = "FFC8A7",
                [CAP] = "FCF276",
                [EMBLEM] = "E44041"
            },
            {
                name = "Rot For Clout",
                [PANTS] = "000000",
                [SHIRT] = "FFFFFF",
                [GLOVES] = "FFFFFF",
                [SHOES] = "000000",
                [HAIR] = "FFFFFF",
                [SKIN] = "FFFFFF",
                [CAP] = "000000",
                [EMBLEM] = "000000"
            },
            {
                name = "Classic",
                [PANTS] = "374155",
                [SHIRT] = "374155",
                [GLOVES] = "374155",
                [SHOES] = "14171F",
                [HAIR] = "FF273E",
                [SKIN] = "FED7A4",
                [CAP] = "FF273E",
                [EMBLEM] = "FF2D4B"
            }
        }
    },
    {
        name = "Luigi Teto",
        model = smlua_model_util_get_id("luigiteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "0000FF",
                [SHIRT] = "00FF00",
                [GLOVES] = "FFFFFF",
                [SHOES] = "721C0E",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "00FF00",
                [EMBLEM] = "00FF00"
            }
        }
    },
    {
        name = "Mesmerizer Teto",
        model = smlua_model_util_get_id("mesteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "2A2A2A",
                [SHIRT] = "FFFFFF",
                [GLOVES] = "FDEA0F",
                [SHOES] = "2A2A2A",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "E41D3E",
                [EMBLEM] = "8BC0E5"
            }
        }
    },
    {
        name = "Triple Baka Teto",
        model = smlua_model_util_get_id("tbteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "9A9A9A",
                [SHIRT] = "9A9A9A",
                [GLOVES] = "444853",
                [SHOES] = "444750",
                [HAIR] = "DD6592",
                [SKIN] = "FAF2DD",
                [CAP] = "DD6592",
                [EMBLEM] = "F5534E"
            }
        }
    },
    {
        name = "Shadow Teto",
        model = smlua_model_util_get_id("shadowteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "1B1B1B",
                [SHIRT] = "1B1B1B",
                [GLOVES] = "FFFFFF",
                [SHOES] = "FF0000",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "1B1B1B",
                [EMBLEM] = "FF4141"
            }
        }
    },
    {
        name = "SynthV Teto",
        model = smlua_model_util_get_id("synthvteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "BBB6BA",
                [SHIRT] = "BBB6BA",
                [GLOVES] = "BBB6BA",
                [SHOES] = "131313",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "B9354D",
                [EMBLEM] = "E5E191"
            }
        }
    },
    {
        name = "Voicepeak Teto",
        model = smlua_model_util_get_id("voiceteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "4A5044",
                [SHIRT] = "4A5044",
                [GLOVES] = "7F9080",
                [SHOES] = "272320",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "D5384E",
                [EMBLEM] = "FFFAF0"
            }
        }
    },
    {
        name = "Spoken For Teto",
        model = smlua_model_util_get_id("spokenteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "FF8D8E",
                [SHIRT] = "FE4759",
                [GLOVES] = "FFFFFF",
                [SHOES] = "FE4759",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "FFFFFF",
                [EMBLEM] = "F8DADC"
            }
        }
    },
    {
        name = "Birdbrain Teto",
        model = smlua_model_util_get_id("bbteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "FECC32",
                [SHIRT] = "F4EDDF",
                [GLOVES] = "FEDD74",
                [SHOES] = "FECC32",
                [HAIR] = "FF2A44",
                [SKIN] = "FFC8A7",
                [CAP] = "FFFFFF",
                [EMBLEM] = "FFFFFF"
            }
        }
    },
    {
        name = "Kasane Teto (Classic)",
        model = smlua_model_util_get_id("classicteto_violet_geo"),
        palettes = {
            {
                [PANTS] = "374155",
                [SHIRT] = "374155",
                [GLOVES] = "374155",
                [SHOES] = "14171F",
                [HAIR] = "FF273E",
                [SKIN] = "FED7A4",
                [CAP] = "FF273E",
                [EMBLEM] = "FF2D4B"
            }
        },
        defaultAnims = true
    },
}

------------------------

CLASSIC_MODELS = {}

function enable_custom_animations()
    for i = 1, #COSTUMETABLE_MIKU do
        if not COSTUMETABLE_MIKU[i].defaultAnims then
            _G.charSelect.character_add_animations(COSTUMETABLE_MIKU[i].model, ANIMTABLE_MIKU, nil, HANDTABLE_MIKU)
        end
    end
    for i = 1, #COSTUMETABLE_TETO do
        if not COSTUMETABLE_TETO[i].defaultAnims then
            _G.charSelect.character_add_animations(COSTUMETABLE_TETO[i].model, ANIMTABLE_TETO, EYETABLE_TETO,
                HANDTABLE_TETO)
        end
    end
    for i = 1, #COSTUMETABLE_NERU do
        if not COSTUMETABLE_NERU[i].defaultAnims then
            _G.charSelect.character_add_animations(COSTUMETABLE_NERU[i].model, ANIMTABLE_NERU, EYETABLE_NERU,
                HANDTABLE_NERU)
        end
    end
end

--[[
function disable_custom_animations()
    for i = 1, #COSTUMETABLE_MIKU do
        if not COSTUMETABLE_MIKU[i].defaultAnims then
            _G.charSelect.character_add_animations(COSTUMETABLE_MIKU[i].model, ANIMTABLE_MIKU_DISABLED, nil,
                HANDTABLE_MIKU_DISABLED)
        end
    end
    for i = 1, #COSTUMETABLE_TETO do
        if not COSTUMETABLE_TETO[i].defaultAnims then
            _G.charSelect.character_add_animations(COSTUMETABLE_TETO[i].model, ANIMTABLE_TETO_DISABLED, EYETABLE_TETO,
                nil)
        end
    end
    for i = 1, #COSTUMETABLE_NERU do
        if not COSTUMETABLE_NERU[i].defaultAnims then
            _G.charSelect.character_add_animations(COSTUMETABLE_NERU[i].model, ANIMTABLE_NERU_DISABLED, EYETABLE_NERU,
                HANDTABLE_NERU_DISABLED)
        end
    end
end
]]

local CSloaded = false
local function on_character_select_load()
    -- Miku

    CT_MIKU = _G.charSelect.character_add(
        "Hatsune Miku",                                                                                                                                                              -- Character Name
        "The Cheerful Vocaloid, Hatsune Miku, makes her debut on the big stage, but this time in a bit of low poly form, can Miku make her way to super stardom and defeat Bowser?", -- Description
        "Violet",                                                                                                                                                                    -- Credits
        "00DFFF",                                                                                                                                                                    -- Menu Color
        COSTUMETABLE_MIKU[1].model,                                                                                                                                                  -- Character Model
        CT_MARIO,                                                                                                                                                                    -- Override Character
        TEX_MIKU_ICON,                                                                                                                                                               -- Life Icon
        1,                                                                                                                                                                           -- Camera Scale
        0                                                                                                                                                                            -- Vertical Offset
    )
    for i = 1, #COSTUMETABLE_MIKU do
        local costume = COSTUMETABLE_MIKU[i]
        if i > 1 then
            _G.charSelect.character_add_costume(CT_MIKU, costume.name, nil, costume.credit, nil, costume.model)
        end
        _G.charSelect.character_add_voice(costume.model, VOICETABLE_MIKU)
        _G.charSelect.character_add_caps(costume.model, MIKU_CAPMODELS)
        for p = 1, #costume.palettes do
            local palette = costume.palettes[p]
            _G.charSelect.character_add_palette_preset(costume.model, palette, palette.name)
        end
        _G.charSelect.character_add_costume_health_meter(CT_MIKU, i, HEALTH_METER_MIKU)
        _G.init_physbone(costume.model, 0, 0.4, 0.5, 30)
        _G.init_physbone(costume.model, 1, 0.4, 0.5, 30)

        if costume.defaultAnims then
            CLASSIC_MODELS[costume.model] = true
        end
    end

    -- Teto

    CT_TETO = _G.charSelect.character_add(
        "Kasane Teto",                                                                                                                           -- Character Name
        "Kasane Teto, the utaloid singer is here! With her red twin drill hair, she is ready to sing with Hatsune Miku in this low poly world!", -- Description
        "Violet",                                                                                                                                -- Credits
        "FF2A44",                                                                                                                                -- Menu Color
        COSTUMETABLE_TETO[1].model,                                                                                                              -- Character Model
        CT_MARIO,                                                                                                                                -- Override Character
        TEX_TETO_ICON,                                                                                                                           -- Life Icon
        1,                                                                                                                                       -- Camera Scale
        0                                                                                                                                        -- Vertical Offset
    )
    for i = 1, #COSTUMETABLE_TETO do
        local costume = COSTUMETABLE_TETO[i]
        if i > 1 then
            _G.charSelect.character_add_costume(CT_TETO, costume.name, nil, costume.credit, nil, costume.model)
        end
        _G.charSelect.character_add_voice(costume.model, VOICETABLE_TETO)
        _G.charSelect.character_add_caps(costume.model, TETO_CAPMODELS)
        for p = 1, #costume.palettes do
            local palette = costume.palettes[p]
            _G.charSelect.character_add_palette_preset(costume.model, palette, palette.name)
        end
        _G.charSelect.character_add_costume_health_meter(CT_TETO, i, HEALTH_METER_TETO)
        _G.init_physbone(costume.model, 0, 0.4, 0.5, 24)
        _G.init_physbone(costume.model, 1, 0.4, 0.5, 24)

        if costume.defaultAnims then
            CLASSIC_MODELS[costume.model] = true
        end
    end

    -- Neru

    CT_NERU = _G.charSelect.character_add(
        "Akita Neru",                                                                                                                                                                               -- Character Name
        "The most stubborn of the trio, Akita Neru, the popular fanloid, makes her debut, even with one ponytail and constantly being on her phone, Neru is ready to rock with her 'baka' friends", -- Description
        "Violet",                                                                                                                                                                                   -- Credits
        "FFBE16",                                                                                                                                                                                   -- Menu Color
        COSTUMETABLE_NERU[1].model,                                                                                                                                                                 -- Character Model
        CT_MARIO,                                                                                                                                                                                   -- Override Character
        TEX_NERU_ICON,                                                                                                                                                                              -- Life Icon
        1,                                                                                                                                                                                          -- Camera Scale
        0                                                                                                                                                                                           -- Vertical Offset
    )
    for i = 1, #COSTUMETABLE_NERU do
        local costume = COSTUMETABLE_NERU[i]
        if i > 1 then
            _G.charSelect.character_add_costume(CT_NERU, costume.name, nil, costume.credit, nil, costume.model)
        end
        _G.charSelect.character_add_voice(costume.model, VOICETABLE_NERU)
        _G.charSelect.character_add_caps(costume.model, NERU_CAPMODELS)
        for p = 1, #costume.palettes do
            local palette = costume.palettes[p]
            _G.charSelect.character_add_palette_preset(costume.model, palette, palette.name)
        end
        _G.charSelect.character_add_costume_health_meter(CT_NERU, i, HEALTH_METER_MIKU)
        _G.init_physbone(costume.model, 1, 0.4, 0.5, 30)

        if costume.defaultAnims then
            CLASSIC_MODELS[costume.model] = true
        end
    end

    --

    enable_custom_animations()

    _G.charSelect.credit_add(TEXT_MOD_NAME, "Violet", "Pack Creator / Models")
    _G.charSelect.credit_add(TEXT_MOD_NAME, "chalz", "Miku/Teto/Akita Voicelines")
    _G.charSelect.credit_add(TEXT_MOD_NAME, "chalz", "Miku SM64 Music")
    _G.charSelect.credit_add(TEXT_MOD_NAME, "King The Memer", "End Scene Code")
    _G.charSelect.credit_add(TEXT_MOD_NAME, "ManIsCat2", "Triple Baka Music & Dialog Code")
    _G.charSelect.credit_add(TEXT_MOD_NAME, "Zam Boni", "Animations")
    _G.charSelect.credit_add(TEXT_MOD_NAME, "Violet", "Animations")
    _G.charSelect.credit_add(TEXT_MOD_NAME, "Wibblus", "Hair Physics & Animations")

    CSloaded = true

    if charSelect.version_get_full().major >= 16 then
        _G.charSelect.character_add_menu_instrumental(CT_MIKU, E_SOUND_MIKU)
        _G.charSelect.character_add_graffiti(CT_MIKU, TEX_MIKU_GRAFFITI)
        _G.charSelect.character_set_nickname(CT_MIKU, "Miku")

        _G.charSelect.character_add_menu_instrumental(CT_TETO, E_SOUND_TETO)
        _G.charSelect.character_add_graffiti(CT_TETO, TEX_TETO_GRAFFITI)
        _G.charSelect.character_set_nickname(CT_TETO, "Teto")

        _G.charSelect.character_add_menu_instrumental(CT_NERU, E_SOUND_NERU)
        _G.charSelect.character_add_graffiti(CT_NERU, TEX_NERU_GRAFFITI)
        _G.charSelect.character_set_nickname(CT_NERU, "Neru")
    end
end

_G.charSelect.config_character_sounds()

hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
