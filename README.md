# dotfiles

CachyOS / Arch, NVIDIA GT 1030. Sway (Wayland), with i3 (X11) kept as a fallback.
Managed with [GNU stow](https://www.gnu.org/software/stow/): each top-level folder is a package that mirrors `$HOME`.

| package    | what                                                      |
|------------|-----------------------------------------------------------|
| `sway`     | Sway config, a 1:1 port of the i3 config                  |
| `waybar`   | Both bars (top + bottom), rebuilt from polybar            |
| `swaylock` | Lock screen                                               |
| `bin`      | `~/.local/bin/sway-run`, which launches Sway with the NVIDIA env |
| `i3`, `polybar`, `picom` | X11 setup, still works from the login screen |
| `rofi`, `dunst`, `alacritty`, `fish`, `nvim` | shared by both sessions |
| `system/`  | files outside `$HOME` (login session entry), installed by `install.sh` |

## Fresh machine

```sh
git clone <this repo> ~/dotfiles && ~/dotfiles/install.sh
```

Secrets (tokens, passwords) go in `~/.config/fish/secrets.fish`, which is gitignored and sourced by `config.fish`.

## Daily use

Edit files normally in `~/.config/...`. They are symlinks into this repo. Then:

```sh
cd ~/dotfiles && git add -A && git commit -m "..." && git push
```

## i3 → Sway mapping

| i3 / X11              | Sway / Wayland              |
|-----------------------|-----------------------------|
| polybar               | waybar                      |
| picom                 | not needed (Sway composites; no animations = faster) |
| nitrogen / feh        | `output * bg` (swaybg)      |
| i3lock                | swaylock                    |
| maim + xclip          | grim + slurp + wl-copy      |
| xob                   | wob                         |
| xrandr                | `output` in sway config / `swaymsg -t get_outputs` |
| redshift              | gammastep                   |

## Troubleshooting NVIDIA

- Logs: `$XDG_RUNTIME_DIR/sway.log`
- Black screen: comment out `WLR_RENDERER=vulkan` in `bin/.local/bin/sway-run`
- Output name for per-monitor settings: `swaymsg -t get_outputs` (likely `HDMI-A-1`)
