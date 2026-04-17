#!/usr/bin/env bash
set -euo pipefail

defaults -currentHost write -g com.apple.keyboard.modifiermapping.0-0-0 -array '{
  HIDKeyboardModifierMappingSrc = 30064771129;
  HIDKeyboardModifierMappingDst = 30064771113;
}'

hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":30064771129,"HIDKeyboardModifierMappingDst":30064771113}]}' >/dev/null 2>&1 || true
