# Charts

Charts I use with [Crawlspace](https://crawlspacenh.com)

All mistakes and inaccuracies are entirely my own. Use at your own risk.

## Syncing to iCloud

The `sync-to-icloud.sh` script syncs the local chart collection to `~/iCloudDrive/Charts/` while preserving the directory structure.

### Usage

Test the sync (no changes made):
```bash
./sync-to-icloud.sh --dry-run
```

Perform the actual sync:
```bash
./sync-to-icloud.sh
```

### What it does

- Copies all `.cho` files from the local repository to iCloud
- Preserves artist directory structure (e.g., `Grateful Dead/Bertha.cho`)
- Detects and copies new files
- Updates files that have changed
- Removes files from iCloud that no longer exist locally
- Shows a summary of changes: new, updated, unchanged, and deleted files

### What it excludes

The following files are **not** synced to iCloud:
- `README.md` - Repository documentation
- `template.cho` - Template file for reference
- `*.sh` - Shell scripts (including the sync script itself)
