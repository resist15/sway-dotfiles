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
| `rofi`, `dunst`, `alacritty`, `fish` | shared by both sessions |
| `nvim`     | Neovim config: a git submodule of [resist15/kickstart.nvim](https://github.com/resist15/kickstart.nvim) |
| `chrome`   | `~/.config/chrome-flags.conf`, which turns on VA-API hardware video decode on NVIDIA |
| `firefox/` | `user.js` (VA-API decode, AV1 off), symlinked into the profile by `install.sh` |
| `system/`  | files outside `$HOME` (login session entry), installed by `install.sh` |

## Fresh machine

```sh
git clone --recurse-submodules <this repo> ~/dotfiles && ~/dotfiles/install.sh
```

Secrets (tokens, passwords) go in `~/.config/fish/secrets.fish`, which is gitignored and sourced by `config.fish`.

## Daily use

Edit files normally in `~/.config/...`. They are symlinks into this repo. Then:

```sh
cd ~/dotfiles && git add -A && git commit -m "..." && git push
```

Neovim changes live in the submodule, so commit and push them there first, then
record the new submodule commit here:

```sh
cd ~/dotfiles/nvim/.config/nvim && git add -A && git commit -m "..." && git push
cd ~/dotfiles && git add nvim/.config/nvim && git commit -m "nvim: bump" && git push
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

## Hardware acceleration (verified 2026-11-13)

- Sway renders with Vulkan on the GT 1030. EGL and GLX (XWayland) also run on NVIDIA.
- VA-API uses `nvidia-vaapi-driver` (NVDEC) for H.264, HEVC and VP9. The GT 1030 has **no AV1** decoder.
- Chrome: with `chrome-flags.conf`, its media log shows `VaapiVideoDecoder` (by default it's software `FFmpegVideoDecoder`/`VpxVideoDecoder`).
  It reports AV1 as not power-efficient, so YouTube on AV1 "Auto" picks VP9.
- Firefox: `user.js` enables VA-API and turns AV1 off, so YouTube sends VP9 or H.264.
- Check it yourself: `vainfo`, `nvidia-smi dmon -s u` (dec column while a video plays), and `chrome://media-internals` → `kVideoDecoderName`.
