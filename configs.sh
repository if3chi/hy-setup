# Create dotfiles structure
mkdir -p ~/.config/hypr ~/.config/rofi ~/.config/ghostty

# Sample Hyprland config placeholder
cat <<EOF > ~/.config/hypr/hyprland.conf
# Hyprland config goes here
EOF

# Rofi power menu
cat <<'EOF' > ~/.config/rofi/powermenu.sh
#!/bin/bash
chosen=$(printf " Shutdown\n Reboot\n Lock\n Logout\n Suspend" | rofi -dmenu -i -p "Power Menu")
case "$chosen" in
  " Shutdown") poweroff ;;
  " Reboot") reboot ;;
  " Lock") hyprlock ;;
  " Logout") hyprctl dispatch exit ;;
  " Suspend") systemctl suspend ;;
esac
EOF
chmod +x ~/.config/rofi/powermenu.sh

# Rofi emoji picker
cat <<'EOF' > ~/.config/rofi/emoji.sh
#!/bin/bash
emoji=$(cat <<EOL
😄 Smile
😂 Laugh
😍 Heart Eyes
👍 Thumbs Up
🔥 Fire
😎 Cool
🎉 Party
😭 Cry
🙌 Hands Up
🤔 Thinking
EOL
 | rofi -dmenu -i -p "Emoji" | awk '{print $1}')

[ -n "$emoji" ] && echo -n "$emoji" | wl-copy
EOF
chmod +x ~/.config/rofi/emoji.sh

# Ghostty config
cat <<EOF > ~/.config/ghostty/config.toml
[terminal]
font_family = "JetBrainsMono Nerd Font"
font_size = 11
line_height = 1.2
theme = "Dracula"
EOF

# Tmux config
cat <<EOF > ~/.tmux.conf
# Enable mouse support
set -g mouse on

# Use Ctrl-A as prefix
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Split window shortcuts
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Vi-style copy mode
setw -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection

# Reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"

# Status bar
set -g status-bg black
set -g status-fg white
set -g status-left-length 40
set -g status-right-length 80
set -g status-left "#[fg=green]#H"
set -g status-right "#[fg=cyan]%Y-%m-%d #[fg=yellow]%H:%M:%S"

# Pane borders
set -g pane-border-style fg=colour238
set -g pane-active-border-style fg=colour39
EOF

# Zsh config
cat <<EOF > ~/.zshrc
export EDITOR=nvim
export TERMINAL=foot

autoload -Uz compinit && compinit
setopt HIST_IGNORE_DUPS SHARE_HISTORY

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias update='sudo pacman -Syu && yay -Syu'

PROMPT='%F{cyan}%n@%m%f:%F{yellow}%~%f$ '
EOF