#!/usr/bin/env bash
#
# Claude Code Starter Kit — Setup Script
#
# Copies template files into the parent directory (your projects root),
# replacing placeholders with your info.
#
# Usage:
#   cd ~/Projects
#   bash claude-code-starter/setup.sh
#
# Or if cloned as _starter:
#   bash _starter/setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$(dirname "$SCRIPT_DIR")"

echo ""
echo "Claude Code Starter Kit"
echo "======================="
echo ""
echo "This will install files into: $TARGET_DIR"
echo ""

# ── Collect info ──────────────────────────────────────────────────────────────

read -rp "Your full name (for git commits): " YOUR_NAME
read -rp "Your email (for git commits): " YOUR_EMAIL
read -rp "Your role (e.g., 'solo developer', 'frontend engineer'): " YOUR_ROLE

if [ -z "$YOUR_NAME" ] || [ -z "$YOUR_EMAIL" ]; then
  echo "ERROR: Name and email are required."
  exit 1
fi

YOUR_ROLE="${YOUR_ROLE:-developer}"

echo ""

# ── Helper ────────────────────────────────────────────────────────────────────

install_file() {
  local src="$1"
  local dest="$2"

  if [ -f "$dest" ]; then
    read -rp "  $dest already exists. Overwrite? [y/N] " answer
    if [[ ! "$answer" =~ ^[Yy] ]]; then
      echo "  Skipped."
      return
    fi
  fi

  cp "$src" "$dest"

  # Replace placeholders
  sed -i '' \
    -e "s|__YOUR_NAME__|$YOUR_NAME|g" \
    -e "s|__YOUR_EMAIL__|$YOUR_EMAIL|g" \
    -e "s|__YOUR_ROLE__|$YOUR_ROLE|g" \
    "$dest" 2>/dev/null || \
  sed -i \
    -e "s|__YOUR_NAME__|$YOUR_NAME|g" \
    -e "s|__YOUR_EMAIL__|$YOUR_EMAIL|g" \
    -e "s|__YOUR_ROLE__|$YOUR_ROLE|g" \
    "$dest"

  echo "  Installed: $(basename "$dest")"
}

copy_file() {
  local src="$1"
  local dest="$2"

  if [ -f "$dest" ]; then
    read -rp "  $dest already exists. Overwrite? [y/N] " answer
    if [[ ! "$answer" =~ ^[Yy] ]]; then
      echo "  Skipped."
      return
    fi
  fi

  cp "$src" "$dest"
  echo "  Installed: $(basename "$dest")"
}

# ── Install ───────────────────────────────────────────────────────────────────

echo "Installing files..."
echo ""

# Templates (need placeholder replacement)
install_file "$SCRIPT_DIR/templates/CLAUDE.md"    "$TARGET_DIR/CLAUDE.md"
install_file "$SCRIPT_DIR/templates/GIT.md"       "$TARGET_DIR/GIT.md"
install_file "$SCRIPT_DIR/templates/SECURITY.md"  "$TARGET_DIR/SECURITY.md"

# Universal files (no customization needed)
copy_file "$SCRIPT_DIR/LOGGING.md"                "$TARGET_DIR/LOGGING.md"
copy_file "$SCRIPT_DIR/templates/MODELS.md"       "$TARGET_DIR/MODELS.md"
copy_file "$SCRIPT_DIR/.claudeignore.template"    "$TARGET_DIR/.claudeignore.template"

echo ""
echo "Done! Files installed to $TARGET_DIR"
echo ""
echo "Next steps:"
echo "  1. Review the files and customize as needed"
echo "  2. Add project-specific CLAUDE.md files in each repo"
echo "  3. Copy .claudeignore.template into repos that need it:"
echo "     cp .claudeignore.template my-repo/.claudeignore"
echo ""
echo "You can now delete this starter directory:"
echo "  rm -rf $SCRIPT_DIR"
echo ""
