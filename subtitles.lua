--- @class XSubtitle
--- @field public text string
--- @field public color Color
--- @field public timeStart number
--- @field public timeEnd number

local COLOR_WHITE  = { r = 255, g = 255, b = 255 }
local COLOR_RED    = { r = 255, g = 50,  b = 50  }
local COLOR_ORANGE = { r = 255, g = 127, b = 0   }
local COLOR_GREEN  = { r = 0,   g = 200, b = 0   }
local COLOR_CYAN   = { r = 0,   g = 255, b = 255 }
local COLOR_BLUE   = { r = 127, g = 127, b = 255 }
local COLOR_PURPLE = { r = 127, g = 0,   b = 255 }

local LYRICS_END_TIME = 187 * 30

--- @param text string
--- @param colorCode string
--- @param timeStart number
--- @param timeEnd number
--- @return XSubtitle
local function LYRIC(text, colorCode, timeStart, timeEnd)
    return {
        text = text,
        color = colorCode,
        timeStart = timeStart,
        timeEnd = timeEnd
    }
end

--- @type XSubtitle[]
local sLyricsTable = {
    LYRIC("Yahoo!!!", COLOR_WHITE, 7.25, 8.25),

    LYRIC("Jump, jump, jump up!", COLOR_CYAN, 19.50, 20.50),
    LYRIC("All the way up to the sky", COLOR_CYAN, 20.50, 21.75),
    LYRIC("Seems so far but you'll make it if you try", COLOR_CYAN, 21.75, 25.10),
    LYRIC("Reach for the stars shining so bright", COLOR_CYAN, 25.10, 27.50),
    LYRIC("Go so far and see every single sight", COLOR_CYAN, 27.50, 30.75),
    LYRIC("Jump, jump, jump up!", COLOR_CYAN, 30.75, 31.50),
    LYRIC("All the way up to the moon", COLOR_CYAN, 31.50, 33.00),
    LYRIC("So high up, see how far you can go", COLOR_CYAN, 33.00, 36.00),
    LYRIC("Reach for the stars shining so bright", COLOR_CYAN, 36.00, 38.60),
    LYRIC("An adventure is waiting for you!", COLOR_CYAN, 38.60, 41.75),

    LYRIC("Step into the frame, I won't be afraid", COLOR_RED, 41.75, 47.40),
    LYRIC("Shining stars and secrets call my name", COLOR_RED, 47.40, 53.00),

    LYRIC("Shine above the skies, I will chase the light", COLOR_WHITE, 53.00, 55.30),
    LYRIC("Every jump I reach so high, through the day and the night", COLOR_WHITE, 55.30, 58.50),
    LYRIC("Go out and see the world, you can shine so bright", COLOR_WHITE, 58.50, 61.00),
    LYRIC("We'll give it all we got, chasing dreams with all our might", COLOR_WHITE, 61.00, 64.00),

    LYRIC("Jump jump so far!", COLOR_CYAN, 75.00, 76.30),
    LYRIC("You'll find a new galaxy", COLOR_CYAN, 76.30, 77.75),
    LYRIC("Leave your mark, make all new discoveries", COLOR_CYAN, 77.75, 80.75),
    LYRIC("Beyond the stars shining so bright", COLOR_CYAN, 80.75, 83.25),
    LYRIC("An adventure is waiting for you!", COLOR_CYAN, 83.25, 86.50),

    LYRIC("Every star I hold, it becomes my guide", COLOR_RED, 86.50, 91.75),
    LYRIC("Chasing the light, drawing close in sight", COLOR_RED, 91.75, 97.50),

    LYRIC("Shine above the skies, I will chase the light", COLOR_WHITE, 97.50, 100.00),
    LYRIC("Every jump I reach so high, through the day and the night", COLOR_WHITE, 100.00, 103.25),
    LYRIC("Go out and see the world, you can shine so bright", COLOR_WHITE, 103.25, 105.75),
    LYRIC("So we'll give it all we got, chasing dreams with all our might", COLOR_WHITE, 105.75, 108.75),

    LYRIC("Shine above the skies, I will chase the light", COLOR_WHITE, 108.75, 111.40),
    LYRIC("Every jump I reach so high, through the day and the night", COLOR_WHITE, 111.40, 114.25),
    LYRIC("Go out and see the world, you can shine so bright", COLOR_WHITE, 114.25, 116.75),
    LYRIC("So we'll see this to the end, reaching for our toughest fight", COLOR_WHITE, 116.75, 121.00),

    LYRIC("Here we go!!!", COLOR_WHITE, 135.00, 137.00),

    LYRIC("If I keep leaping throughout the unknown,", COLOR_RED, 147.75, 153.50),
    LYRIC("I'll shape a story that is my own", COLOR_RED, 153.50, 159.00),

    LYRIC("Shine above the skies, I will chase the light", COLOR_WHITE, 159.00, 161.50),
    LYRIC("Every jump I reach so high, through the day and the night", COLOR_WHITE, 161.50, 164.50),
    LYRIC("Go out and see the world, you can shine so bright", COLOR_WHITE, 164.50, 167.00),
    LYRIC("So we'll give it all we got, chasing dreams with all our might", COLOR_WHITE, 167.00, 170.00),

    LYRIC("Shine above the skies, I will chase the light", COLOR_WHITE, 170.00, 172.50),
    LYRIC("Every jump I reach so high, through the day and the night", COLOR_WHITE, 172.50, 175.80),
    LYRIC("Go out and see the world, you can shine so bright", COLOR_WHITE, 175.80, 178.25),
    LYRIC("So we'll see this to the end, nothing's gonna stop our flight", COLOR_WHITE, 178.25, 182.50),
}

--- @type XSubtitle[]
local sCreditsTable = {
    LYRIC("Violet: Pack Creator / Modeler / Animator", COLOR_PURPLE, 138.00, 143.00),
    LYRIC("Chalz: Musician", COLOR_CYAN, 143.00, 148.00),
    LYRIC("wibblus: Hair Physics", COLOR_GREEN, 148.00, 153.00),
    LYRIC("Baconator2558: Programmer", COLOR_ORANGE, 153.00, 158.00),
    LYRIC("ManIsCat2: Music / Dialog Programmer", COLOR_WHITE, 158.00, 163.00),
    LYRIC("Zam Boni: Animator", COLOR_GREEN, 163.00, 168.00),
    LYRIC("SwagSkeleton: Mod Menu Programming", COLOR_BLUE, 168.00, 173.00),
    LYRIC("King The Memer: Custom Cake Screen", COLOR_BLUE, 173.00, 178.00),
    LYRIC("Agent X: The Great Subtitler", COLOR_ORANGE, 178.00, 182.50)
}

subtitleTimer = -1

--- @param message string
--- @param x number
--- @param y number
--- @param scale number
local function djui_hud_print_text_centered(message, x, y, scale)
    local measure = djui_hud_measure_text(message)
    djui_hud_print_text(message, x - (measure * 0.5) * scale, y, scale)
end

--- @param subtitleTable XSubtitle[]
local function get_current_subtitle(subtitleTable)
    for _, lyric in ipairs(subtitleTable) do
        if subtitleTimer >= lyric.timeStart * 30 and subtitleTimer <= lyric.timeEnd * 30 then
            return lyric
        end
    end

    return nil
end

--- @param subtitleTable XSubtitle[]
--- @param y number
--- @param bounce boolean
local function hud_render_subtitle(subtitleTable, y, bounce)
    local subtitle = get_current_subtitle(subtitleTable)
    if subtitle ~= nil then
        local scale = 0.5
        if bounce then
            scale = scale + math.sin(subtitleTimer * 0.5) * 0.01
        end
        local x = djui_hud_get_screen_width() * 0.5
        local length = (djui_hud_measure_text(subtitle.text) * scale) + 4

        djui_hud_set_color(0, 0, 0, 127)
        djui_hud_render_rect(x - length * 0.5, y + (2 * scale), length, 32 * scale)
        djui_hud_set_color(subtitle.color.r, subtitle.color.g, subtitle.color.b, 255)
        djui_hud_print_text_centered(subtitle.text, x, y, scale)
    end
end

local function x_subtitle_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)

    if subtitleTimer == -1 then return end

    hud_render_subtitle(sLyricsTable, djui_hud_get_screen_height() - 30, true)
    hud_render_subtitle(sCreditsTable, 0, false)

    subtitleTimer = subtitleTimer + 1
    if subtitleTimer > LYRICS_END_TIME then
        subtitleTimer = -1
    end
end

hook_event(HOOK_ON_HUD_RENDER, x_subtitle_render)