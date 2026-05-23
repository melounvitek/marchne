#!/usr/bin/env bash
set -euo pipefail

defaults -currentHost write -g com.apple.keyboard.modifiermapping.0-0-0 -array '{
  HIDKeyboardModifierMappingSrc = 30064771129;
  HIDKeyboardModifierMappingDst = 30064771113;
}'

"$HOME/.local/bin/marchne-apply-keyboard-mapping" || true

launch_agent="$HOME/Library/LaunchAgents/com.marchne.keyboard.plist"
if [[ -f "$launch_agent" ]]; then
  launchctl bootout "gui/$(id -u)" "$launch_agent" >/dev/null 2>&1 || true
  launchctl bootstrap "gui/$(id -u)" "$launch_agent" >/dev/null 2>&1 || true
  launchctl enable "gui/$(id -u)/com.marchne.keyboard" >/dev/null 2>&1 || true
fi
