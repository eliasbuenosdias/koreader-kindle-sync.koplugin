-- Parse KOReader sidecar files
local lfs = require("libs/libkoreader-lfs")
local DocSettings = require("docsettings")

local MetadataParser = {}

function MetadataParser:parseBook(book_path)
    if not book_path or book_path == "" then
        return nil
    end

    local book_data = {
        title = nil,
        author = nil,
        isbn = nil,
        progress = 0,
        current_page = 0,
        highlights = {}
    }

    -- Get document settings (sidecar)
    local doc_settings = DocSettings:open(book_path)
    if not doc_settings then
        return nil
    end

    -- Extract metadata
    local metadata = doc_settings:readSetting("doc_props") or {}
    book_data.title = metadata.title or self:extractTitleFromPath(book_path)
    book_data.author = metadata.authors or metadata.author or "Unknown Author"
    book_data.isbn = metadata.isbn or metadata.series or ""

    -- Extract highlights
    local highlights_data = doc_settings:readSetting("highlight") or {}

    for page, page_highlights in pairs(highlights_data) do
        if type(page_highlights) == "table" then
            for _, highlight in ipairs(page_highlights) do
                if type(highlight) == "table" and highlight.text then
                    table.insert(book_data.highlights, {
                        text = highlight.text,
                        page = highlight.page or page,
                        note = highlight.note or "",
                        datetime = highlight.datetime or os.date("%Y-%m-%d %H:%M:%S"),
                        pos0 = highlight.pos0,
                        pos1 = highlight.pos1,
                    })
                end
            end
        end
    end

    -- Sort highlights by page/position
    table.sort(book_data.highlights, function(a, b)
        return (a.page or 0) < (b.page or 0)
    end)

    doc_settings:close()

    return book_data
end

function MetadataParser:extractTitleFromPath(path)
    local filename = path:match("^.+/(.+)$") or path
    local title = filename:match("^(.+)%..+$") or filename
    return title:gsub("_", " ")
end

return MetadataParser
