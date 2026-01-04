# KOReader Kindle My Clippings Sync Plugin

## 📖 Description

This plugin exports highlights and notes from KOReader to Kindle's official `My Clippings.txt` format, allowing Amazon to automatically sync them to your account and Goodreads.

**Important:** Only books with a valid ISBN will be recognized and synced by Amazon to Goodreads. Books without ISBN will have highlights exported locally but won't sync to Amazon.

---

## ✨ Features

- ✅ Export highlights to Kindle's `My Clippings.txt` format
- ✅ Automatic duplicate detection (won't export same highlight twice)
- ✅ Auto-sync option: export on book close
- ✅ ISBN detection: warns if book won't sync to Amazon
- ✅ Works on Kindle (jailbroken), Kobo, Android, and other devices
- ✅ No external dependencies

---

## 📥 Installation

### 1. Download Plugin

Download all files from this repository and place them in a folder named `koreader-kindle-sync.koplugin`

### 2. Install to Device

Copy the `koreader-kindle-sync.koplugin` folder to:

- **Kindle (jailbroken)**: `/mnt/us/koreader/plugins/`
- **Kobo**: `/mnt/onboard/.adds/koreader/plugins/`
- **Android**: `/sdcard/koreader/plugins/`
- **Other devices**: Check KOReader documentation for plugin path

### 3. Restart KOReader

Close and reopen KOReader to load the plugin.

---

## 🚀 Usage

### Manual Export

1. Open a book in KOReader
2. Tap **Menu (⚙️) > Tools > Kindle My Clippings Sync > Export to My Clippings.txt**
3. Review the confirmation dialog:
   - ✅ ISBN detected = Will sync to Amazon/Goodreads
   - ⚠️ No ISBN = Local export only (won't sync to Amazon)
4. Tap **Export**
5. Amazon will sync highlights in a few minutes (for books with ISBN)

### Auto-Sync on Book Close

1. Go to **Menu > Tools > Kindle My Clippings Sync**
2. Enable **"Auto-sync on book close"**
3. Highlights will export automatically every time you close a book

---

## 📂 Output Location

Highlights are saved to:

- **Kindle**: `/mnt/us/documents/My Clippings.txt`
- **Kobo**: `/mnt/onboard/My Clippings.txt`
- **Android**: `/sdcard/My Clippings.txt`

---

## ⚠️ Important Notes

### Books That Will Sync to Amazon/Goodreads

- ✅ Books with valid ISBN in metadata
- ✅ Books purchased from Amazon (if you use KOReader on native Kindle books)
- ✅ Sideloaded books with proper ISBN metadata

### Books That WON'T Sync to Amazon

- ❌ Books without ISBN
- ❌ Self-published books not in Amazon catalog
- ❌ Scanned PDFs without metadata
- ❌ Books with incorrect/invalid ISBN

**Solution:** The plugin will warn you if a book won't sync. Highlights are still saved locally in `My Clippings.txt` for your records.

---

## 🛠️ Troubleshooting

### "Error: Cannot write to My Clippings.txt"

- **Kindle**: Make sure device is not in USB mode
- **Android**: Check storage permissions
- **All devices**: Verify KOReader has write access to the documents folder

### "No highlights found"

- Make sure you've actually highlighted text in the book
- Check that highlights are visible in KOReader's bookmark menu

### Highlights Don't Appear in Goodreads

- **Verify ISBN**: Only books with ISBN sync to Amazon
- **Wait**: Amazon sync can take 5-30 minutes
- **Check Amazon**: Visit https://read.amazon.com to see if highlights appear there first
- **Goodreads connection**: Make sure your Amazon and Goodreads accounts are linked

---

## 🤝 Contributing

Pull requests and bug reports welcome! Please open an issue on GitHub.

---

## 📄 License

MIT License - see LICENSE file for details

---

## ⭐ Credits

Created by the KOReader community
Plugin development guide: https://github.com/koreader/koreader/wiki/Plugin-development
