#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${ARCHNE_MAC_REPO_URL:-https://github.com/melounvitek/archne_mac.git}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
TEMP_DIR=""

cleanup() {
  if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
  fi
}

trap cleanup EXIT

repo_dir() {
  if [[ -f "$SCRIPT_DIR/Brewfile" && -d "$SCRIPT_DIR/home" ]]; then
    printf '%s\n' "$SCRIPT_DIR"
    return
  fi

  TEMP_DIR="$(mktemp -d)"
  git clone --depth 1 "$REPO_URL" "$TEMP_DIR/archne_mac" >/dev/null
  printf '%s\n' "$TEMP_DIR/archne_mac"
}

install_xcode_clt() {
  if xcode-select -p >/dev/null 2>&1; then
    return
  fi

  xcode-select --install
  printf 'Install Xcode Command Line Tools, then rerun install.sh.\n' >&2
  exit 1
}

setup_brew_shellenv() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    setup_brew_shellenv
    return
  fi

  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  setup_brew_shellenv
}

install_opencode() {
  if command -v opencode >/dev/null 2>&1 || [[ -x "$HOME/.opencode/bin/opencode" ]]; then
    return
  fi

  curl -fsSL https://opencode.ai/install | bash
}

copy_home() {
  local source_dir="$1/home"
  local ghostty_xdg_config="$HOME/.config/ghostty/config.ghostty"
  local ghostty_macos_config="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"

  mkdir -p "$HOME/Applications/Chrome Apps.localized"
  rsync -a --exclude '/.config/ghostty/config.ghostty' "$source_dir/" "$HOME/"

  if [[ -s "$ghostty_xdg_config" || -s "$ghostty_macos_config" ]]; then
    return
  fi

  mkdir -p "$(dirname "$ghostty_xdg_config")"
  cp "$source_dir/.config/ghostty/config.ghostty" "$ghostty_xdg_config"
}

configure_git() {
  git config --global core.editor nvim
}

main() {
  local repo

  install_xcode_clt
  repo="$(repo_dir)"
  install_homebrew

  brew bundle --file="$repo/Brewfile"
  install_opencode
  copy_home "$repo"
  configure_git
  bash "$repo/macos.sh"

  printf '\nManual steps:\n'
  cat "$repo/manual_steps.md"
}

main "$@"
