#!/home/linuxbrew/.linuxbrew/bin/zsh

# sync-to-icloud.sh - Sync local .cho files to iCloud preserving directory structure

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directories
SOURCE_DIR="$(pwd)"
DEST_DIR="${HOME}/iCloudDrive/Charts"

# Check if destination directory exists
if [[ ! -d "$DEST_DIR" ]]; then
    echo "${RED}Error: Destination directory not found: ${DEST_DIR}${NC}"
    exit 1
fi

echo "${BLUE}Syncing from: ${SOURCE_DIR}${NC}"
echo "${BLUE}Syncing to:   ${DEST_DIR}${NC}"
echo ""

# Check if this is a dry run
DRY_RUN=false
if [[ "$1" == "--dry-run" || "$1" == "-n" ]]; then
    DRY_RUN=true
    echo "${YELLOW}DRY RUN MODE - No files will be modified${NC}"
    echo ""
fi

# Counters
COPIED=0
UPDATED=0
SKIPPED=0
DELETED=0

# Find all .cho files, excluding template.cho
while IFS= read -r source_file; do
    # Get relative path from source directory
    rel_path="${source_file#${SOURCE_DIR}/}"

    # Skip if it's template.cho
    basename="${source_file:t}"
    if [[ "$basename" == "template.cho" ]]; then
        continue
    fi

    # Construct destination path
    dest_file="${DEST_DIR}/${rel_path}"
    dest_dir="${dest_file:h}"

    # Check if file needs to be copied or updated
    if [[ ! -f "$dest_file" ]]; then
        # New file
        echo "${GREEN}[NEW]${NC} ${rel_path}"
        if [[ "$DRY_RUN" == false ]]; then
            mkdir -p "$dest_dir"
            cp "$source_file" "$dest_file"
        fi
        ((COPIED++))
    elif ! cmp -s "$source_file" "$dest_file"; then
        # File exists but content differs
        echo "${YELLOW}[UPDATE]${NC} ${rel_path}"
        if [[ "$DRY_RUN" == false ]]; then
            mkdir -p "$dest_dir"
            cp "$source_file" "$dest_file"
        fi
        ((UPDATED++))
    else
        # File is identical
        ((SKIPPED++))
    fi
done < <(find "$SOURCE_DIR" -type f -name "*.cho" 2>/dev/null)

# Optional: Clean up files in destination that no longer exist in source
# Find files in destination that don't exist in source
while IFS= read -r dest_file; do
    # Get relative path from destination directory
    rel_path="${dest_file#${DEST_DIR}/}"

    # Skip template.cho in destination
    basename="${dest_file:t}"
    if [[ "$basename" == "template.cho" ]]; then
        continue
    fi

    # Check if corresponding source file exists
    source_file="${SOURCE_DIR}/${rel_path}"
    if [[ ! -f "$source_file" ]]; then
        echo "${RED}[DELETE]${NC} ${rel_path}"
        if [[ "$DRY_RUN" == false ]]; then
            rm "$dest_file"
        fi
        ((DELETED++))
    fi
done < <(find "$DEST_DIR" -type f -name "*.cho" 2>/dev/null)

# Summary
echo ""
echo "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "${BLUE}SUMMARY${NC}"
echo "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "${GREEN}New files:     ${COPIED}${NC}"
echo "${YELLOW}Updated files: ${UPDATED}${NC}"
echo "Unchanged:     ${SKIPPED}"
echo "${RED}Deleted files: ${DELETED}${NC}"
echo ""

if [[ "$DRY_RUN" == true ]]; then
    echo "${YELLOW}DRY RUN - Run without --dry-run to actually sync files${NC}"
else
    echo "${GREEN}Sync completed successfully${NC}"
fi
