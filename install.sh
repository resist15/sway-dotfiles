#!/usr/bin/env bash
# Dotfiles installer: installs Wayland packages, backs up existing configs,
# symlinks everything with GNU stow, and adds the "Sway (NVIDIA)" login session.
set -euo pipefail
cd "$(dirname "$0")"

# nvim/.config/nvim is a git submodule (github.com/resist15/kickstart.nvim)
git submodule update --init --recursive

PACKAGES=(rofi dunst alacritty fish nvim sway waybar swaylock bin chrome)

if [[ "${1:-}" != "--no-pkgs" ]]; then
  sudo pacman -S --needed \
    stow swayfx swaybg swaylock swayidle waybar wob \
    xorg-xwayland xdg-desktop-portal-wlr wl-clipboard grim slurp \
    gammastep pamixer playerctl libnotify \
    rofi dunst dex polkit-gnome jq capitaine-cursors
fi

# Back up any real (non-symlink) config that stow would collide with
BACKUP="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
for pkg in "${PACKAGES[@]}"; do
  while IFS= read -r -d '' f; do
    target="$HOME/${f#"$pkg"/}"
    if [[ -e "$target" && ! -L "$target" ]]; then
      mkdir -p "$BACKUP/$(dirname "${target#"$HOME"/}")"
      mv "$target" "$BACKUP/${target#"$HOME"/}"
    fi
  done < <(find "$pkg" -mindepth 1 \( -type f -o -type l \) -print0)
done
[[ -d "$BACKUP" ]] && echo "Backed up old configs to $BACKUP"

stow -v -t "$HOME" "${PACKAGES[@]}"

# Firefox: link user.js (hardware video decode prefs) into the default profile
for prof in "$HOME"/.config/mozilla/firefox/*.default-release "$HOME"/.mozilla/firefox/*.default-release; do
  [[ -d "$prof" ]] && ln -sf "$PWD/firefox/user.js" "$prof/user.js"
done

cmp -s system/sway-nvidia.desktop /usr/share/wayland-sessions/sway-nvidia.desktop \
  || sudo install -Dm644 system/sway-nvidia.desktop /usr/share/wayland-sessions/sway-nvidia.desktop
echo "Done. Log out and pick 'Sway (NVIDIA)' in ly."
