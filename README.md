# tomql Quick Look Extension

macOS Quick Look extension for `.toml` files. Right-click any `.toml` file and select "Quick Look" to preview it as plain text.

## Implementation Notes

### Challenges Overcome

1. **No standard `.toml` UTType**: macOS doesn't export a public `public.toml` UTType. Solution: Created custom `com.hippietrail.toml` and exported it via the host app's Info.plist.

2. **UTType export not working with generated Info.plist**: Xcode's `GENERATE_INFOPLIST_FILE = YES` doesn't properly handle `INFOPLIST_KEY_UTExportedTypeDeclarations` arrays. Solution: Switched to manual `Info-generated.plist` with `GENERATE_INFOPLIST_FILE = NO`.

3. **Extension not loading files**: Initial implementation didn't read file contents. Issues were:
   - Missing NSTextView outlet connection in XIB
   - Need to explicitly wire outlets in the NIB file for QuickLook extensions
   - File read had to happen on main thread via DispatchQueue

### Build & Test

```bash
xcodebuild build -scheme tomql-host-app
qlmanage -r  # Reset QuickLook daemon
qlmanage -p /path/to/file.toml
```

Or in Finder: Right-click `.toml` file → Quick Look (spacebar)

### Key Files

- `tomql-preview-extension/PreviewViewController.swift` - Loads & displays TOML as text
- `tomql-host-app/Info-generated.plist` - Declares custom `com.hippietrail.toml` UTType
- `tomql-preview-extension/Info.plist` - Extension configuration
- `tomql-preview-extension/Base.lproj/PreviewViewController.xib` - Text view UI
