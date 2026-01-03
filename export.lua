-- Export to Kindle My Clippings.txt format
local lfs = require("libs/libkoreader-lfs")
local Device = require("device")

local Exporter = {}

-- Kindle My Clippings.txt paths by device
local CLIPPINGS_PATHS = {
    kindle = "/mnt/us/documents/My Clippings.txt",
    kobo = "/mnt/onboard/My Clippings.txt",
    android = "/sdcard/My Clippings.txt",
    fallback = "./My Clippings.txt",
}

function Exporter:getClippingsPath()
    if Device:isKindle() then
        return CLIPPINGS_PATHS.kindle
    elseif Device:isKobo() then
        return CLIPPINGS_PATHS.kobo
    elseif Device:isAndroid() then
        return CLIPPINGS_PATHS.android
    else
        return CLIPPINGS_PATHS.fallback
    end
end

function Exporter:exportToMyClippings(book_data)
    local result = {
        success = false,
        added = 0,
        error = nil
    }

    if not book_data or not book_data.highlights or #book_data.highlights == 0 then
        result.error = "No highlights to export"
        return result
    end

    local clippings_path = self:getClippingsPath()

    -- Read existing clippings
    local existing_content = ""
    local existing_hashes = {}

    local file = io.open(clippings_path, "r")
    if file then
        existing_content = file:read("*all")
        file:close()

        -- Build hash set of existing highlights to avoid duplicates
        for highlight_block in existing_content:gmatch("([^
]*%([^
]*%).-
==========)") do
            local hash = self:generateHash(highlight_block)
            existing_hashes[hash] = true
        end
    end

    -- Generate new clippings
    local new_clippings = {}
    local title_author = string.format("%s (%s)", 
        book_data.title or "Unknown",
        book_data.author or "Unknown Author"
    )

    for _, highlight in ipairs(book_data.highlights) do
        local location = highlight.page or "Unknown"
        local datetime = self:formatKindleDate(highlight.datetime)
        local text = highlight.text or ""

        -- Build Kindle format clipping
        local clipping = string.format([[%s
- Your Highlight on page %s | Added on %s

%s
==========]],
            title_author,
            location,
            datetime,
            text
        )

        -- Check if not duplicate
        local hash = self:generateHash(clipping)
        if not existing_hashes[hash] then
            table.insert(new_clippings, clipping)
            result.added = result.added + 1
        end
    end

    -- Write back to file
    if #new_clippings > 0 then
        local output_file = io.open(clippings_path, "a")
        if output_file then
            if existing_content ~= "" and not existing_content:match("
$") then
                output_file:write("
")
            end
            for _, clipping in ipairs(new_clippings) do
                output_file:write(clipping)
                output_file:write("
")
            end
            output_file:close()
            result.success = true
        else
            result.error = string.format("Cannot write to %s. Check permissions.", clippings_path)
        end
    else
        result.success = true
        result.added = 0
    end

    return result
end

function Exporter:formatKindleDate(datetime_str)
    -- Input: "2026-01-03 22:30:00" or os.time()
    -- Output: "Saturday, 3 January 2026 22:30"

    local year, month, day, hour, min, sec

    if type(datetime_str) == "string" then
        year, month, day, hour, min, sec = datetime_str:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    end

    if not year then
        return os.date("%A, %d %B %Y %H:%M")
    end

    local time = os.time({
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour) or 0,
        min = tonumber(min) or 0,
        sec = tonumber(sec) or 0
    })

    return os.date("%A, %e %B %Y %H:%M", time)
end

function Exporter:generateHash(text)
    -- Simple hash for duplicate detection
    local hash = 0
    for i = 1, #text do
        hash = (hash * 31 + string.byte(text, i)) % 2147483647
    end
    return tostring(hash)
end

return Exporter
