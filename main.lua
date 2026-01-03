-- Main plugin logic
local Device = require("device")
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container")
local InfoMessage = require("ui/widget/infomessage")
local ConfirmBox = require("ui/widget/confirmbox")
local _ = require("gettext")

local MetadataParser = require("plugins.koreader-kindle-sync.metadata_parser")
local Exporter = require("plugins.koreader-kindle-sync.export")

local KindleSync = WidgetContainer:extend{
    name = "koreader-kindle-sync",
    is_doc_only = true,
}

function KindleSync:init()
    self.ui.menu:registerToMainMenu(self)
    self.settings = G_reader_settings:readSetting("kindle_sync") or {
        auto_sync_on_close = false,
    }
end

function KindleSync:addToMainMenu(menu_items)
    menu_items.kindle_sync = {
        text = _("Kindle My Clippings Sync"),
        sorting_hint = "tools",
        sub_item_table = {
            {
                text = _("Export to My Clippings.txt"),
                callback = function()
                    self:exportCurrentBook()
                end,
            },
            {
                text = _("Auto-sync on book close"),
                checked_func = function()
                    return self.settings.auto_sync_on_close
                end,
                callback = function()
                    self.settings.auto_sync_on_close = not self.settings.auto_sync_on_close
                    G_reader_settings:saveSetting("kindle_sync", self.settings)
                    UIManager:show(InfoMessage:new{
                        text = self.settings.auto_sync_on_close 
                            and _("Auto-sync enabled: highlights will export when closing books")
                            or _("Auto-sync disabled"),
                    })
                end,
            },
            {
                text = _("About"),
                keep_menu_open = true,
                callback = function()
                    UIManager:show(InfoMessage:new{
                        text = _([[Exports KOReader highlights to Kindle's My Clippings.txt format.

Amazon will sync books with valid ISBN to your account and Goodreads.

Books without ISBN won't sync to Amazon but highlights are still saved locally.]]),
                    })
                end,
            },
        },
    }
end

function KindleSync:exportCurrentBook()
    if not self.ui.document then
        UIManager:show(InfoMessage:new{
            text = _("No book currently open"),
        })
        return
    end

    local book_path = self.ui.document.file
    local book_data = MetadataParser:parseBook(book_path)

    if not book_data then
        UIManager:show(InfoMessage:new{
            text = _("Error: Could not read book metadata"),
        })
        return
    end

    if not book_data.highlights or #book_data.highlights == 0 then
        UIManager:show(InfoMessage:new{
            text = _("No highlights found in this book"),
        })
        return
    end

    local has_isbn = book_data.isbn and book_data.isbn ~= ""
    local isbn_warning = has_isbn 
        and _("✅ ISBN detected → Will sync to Amazon") 
        or _("⚠️ No ISBN → Won't sync to Amazon (local export only)")

    UIManager:show(ConfirmBox:new{
        text = string.format(_([[Export to My Clippings.txt

📖 "%s"
%s
📝 %d highlight(s) to export

Continue?]]), 
            book_data.title or "Unknown",
            isbn_warning,
            #book_data.highlights
        ),
        ok_text = _("Export"),
        ok_callback = function()
            self:doExport(book_data, has_isbn)
        end,
    })
end

function KindleSync:doExport(book_data, has_isbn)
    local result = Exporter:exportToMyClippings(book_data)

    if result.success then
        local sync_msg = has_isbn
            and _("

Amazon will sync to Goodreads in a few minutes")
            or _("

⚠️ Book has no ISBN - won't sync to Amazon")

        UIManager:show(InfoMessage:new{
            text = string.format(_([[✅ Export successful!

• %d highlight(s) added
• Saved to: My Clippings.txt
• Last update: %s%s]]),
                result.added or 0,
                os.date("%Y-%m-%d %H:%M"),
                sync_msg
            ),
        })
    else
        UIManager:show(InfoMessage:new{
            text = string.format(_("❌ Export failed:
%s"), result.error or "Unknown error"),
        })
    end
end

function KindleSync:onCloseDocument()
    if self.settings.auto_sync_on_close then
        -- Silent export when auto-sync is enabled
        if self.ui.document then
            local book_path = self.ui.document.file
            local book_data = MetadataParser:parseBook(book_path)
            if book_data and book_data.highlights and #book_data.highlights > 0 then
                Exporter:exportToMyClippings(book_data)
            end
        end
    end
end

return KindleSync
