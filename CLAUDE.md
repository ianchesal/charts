# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of guitar/ukulele chord charts in ChoPro (.cho) format, organized by artist. The charts are used with [Crawlspace](https://crawlspacenh.com) software.

The collection includes artists spanning multiple genres and decades, with notable concentrations in:
- Grateful Dead (largest collection with 18 songs)
- Classic rock (Beatles, Rolling Stones, Who, Neil Young)
- Jam bands (Phish, Jerry Garcia Band)
- Alternative/indie (Talking Heads, Ween, Tragically Hip)
- Blues/folk (Bob Dylan, Traffic, Little Feat)

## File Structure and Organization

- Charts are organized in artist-specific directories (e.g., `Grateful Dead/`, `Beatles/`, etc.)
- All chart files use the `.cho` extension (ChoPro format)
- `template.cho` serves as a reference template showing the standard ChoPro format (excluded from sync)
- Each chart includes metadata headers like `{title:}`, `{artist:}`, and `{key:}`
- Artist directories follow naming conventions:
  - Band names: `Grateful Dead/`, `Beatles/`, `Rolling Stones/` (no "The" prefix)
  - Solo artists: `Bob Dylan/`, `Neil Young/`, `Van Morrison/` (full name, not lastname-first)
  - Multi-word artists: `Little Feat/`, `Talking Heads/`, `Jimmy Cliff/`

### Excluded Files

The following files exist in the repository but are **not synced to iCloud**:
- `README.md` - Repository documentation
- `template.cho` - Reference template for creating new charts
- `*.sh` - Shell scripts (consolidate.sh, sync-to-icloud.sh, etc.)
- `.git/` and `.gitignore` - Version control files

## iCloud Synchronization

This repository syncs with `~/iCloudDrive/Charts/` to make charts available to Crawlspace on other devices.

### Available Scripts

**`sync-to-icloud.sh`** - Syncs local charts to iCloud
- Copies all `.cho` files from local repo to `~/iCloudDrive/Charts/`
- Preserves directory structure (artist folders)
- Detects new, updated, and unchanged files
- Removes orphaned files from iCloud that no longer exist locally
- Supports `--dry-run` mode for safe testing
- Run with: `./sync-to-icloud.sh` or `./sync-to-icloud.sh --dry-run`

**`consolidate.sh`** - Compares iCloud with local repo
- Scans `~/iCloudDrive/Charts/` for all `.cho` files
- Reports which files exist in the local repository
- Highlights missing files
- Useful for verifying sync status or finding files to add
- Run with: `./consolidate.sh`

## ChoPro Format Standards

Charts follow ChoPro conventions:
- Chord symbols are enclosed in square brackets: `[G]`, `[C]`, `[F7]`
- Comments/sections use curly braces: `{c: Verse}`, `{c: Chorus}`, `{c: Intro}`, `{c: Outro}`, `{c: Jam}`
- Metadata uses key-value format: `{title: Song Name}`, `{artist: Artist Name}`, `{key: Key}`
- Chord progressions can be written on separate lines or inline with lyrics
- Extended chord notation is supported: `[E7add9]`, `[C+]`, `[C6]`, `[C7]`
- Chord timing/duration can be indicated: `[E7 (long time)]`, `[E7 (4 bars)]`
- Riffs and patterns can be referenced: `[E7 (riff)]`, `E7 riff`

## Common Operations

- When creating a new artist directory omit `The` from the artist's name
- When creating a new artist directory for a solo artist use the full name. Don't use a pattern where their last name comes first like `<lastname>, <firstname>`.

When working with charts:
- Use the existing template.cho as reference for formatting new charts
- Maintain consistent artist directory organization
- Preserve ChoPro format standards for compatibility with Crawlspace
- Keep chord notation consistent with existing charts in the collection
