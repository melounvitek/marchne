# archne_mac

My one-command configurator for a clean macOS install.

## Install

From a local checkout:

```bash
bash install.sh
```

Remotely:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/melounvitek/archne_mac/main/install.sh)
```

## Included

- `Brewfile` with my basic Homebrew packages and casks
- `~/.zshrc`
- `~/.zprofile`
- `~/.aerospace.toml`
- `~/.config/alacritty/alacritty.toml`
- `~/.config/nvim/`
- `~/Applications/Chrome Apps.localized/`
- `EDITOR` and `VISUAL` set to `nvim`
- Git `core.editor` set to `nvim`
- Caps Lock to Escape remap in `macos.sh`

## Notes

- The installer copies files from `home/` into `$HOME`.
- `borders` is installed from Homebrew and launched by AeroSpace from `~/.aerospace.toml`.
- Some permissions and sign-ins remain manual. See `manual_steps.md`.
