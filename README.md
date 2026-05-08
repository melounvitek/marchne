# m-archne

My one-command configurator for a clean macOS install. Like [Archne](https://github.com/melounvitek/archne/), but for Mac.

## Install
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/melounvitek/marchne/main/install.sh)
```

## Main features
Includes preconfigured
- tiling windows manager [AeroSpace](https://github.com/nikitabobko/AeroSpace) (with [Omarchy-like hotkeys](https://learn.omacom.io/2/the-omarchy-manual/53/hotkeys) for windows and workspaces navigation),
- OhMyZSH,
- Neovim,
- Ghostty terminal,
- OpenCode,
- and many other cool Linux tools.

## System config changes

After installation, your system will have this configured:
- `EDITOR` and `VISUAL` set to `nvim`
- Git `core.editor` set to `nvim`
- Caps Lock remapped to Escape (must-have for vim users!)

## Notes

- The installer copies files from `home/` into `$HOME`.
- The installer preserves any existing non-empty Ghostty config and only installs the repo default when no Ghostty config exists yet.
- Some permissions and sign-ins remain manual. See `manual_steps.md`.
