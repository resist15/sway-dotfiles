source /usr/share/cachyos-fish-config/cachyos-config.fish

# Secrets live in an untracked file (see .gitignore)
test -f ~/.config/fish/secrets.fish; and source ~/.config/fish/secrets.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   # smth smth
end



# Added by Antigravity CLI installer
set -gx PATH "/home/sourav/.local/bin" $PATH
