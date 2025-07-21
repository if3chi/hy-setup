function _load_functions() {
    # Load all custom function files // Directories are ignored
    for file in "${ZDOTDIR:-$HOME/.config/zsh}/functions/"*.zsh; do
        [ -r "$file" ] && source "$file"
    done
}

export EDITOR=nvim
export TERMINAL=ghostty
export ZSH="$HOME/.oh-my-zsh"

# -----------------------------------------------------
# CUSTOMIZATION
# -----------------------------------------------------
POSH=agnoster

# -----------------------------------------------------
# oh-myzsh plugins
# -----------------------------------------------------
plugins=(
    git
    fzf
    sudo
    web-search
    archlinux
    zsh-autosuggestions
#    zsh-syntax-highlighting
    fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

# Set-up oh-my-zsh
source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------
# Set-up FZF key bindings (CTRL R for fuzzy history finder)
# -----------------------------------------------------
source <(fzf --zsh)

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

#Aliases
alias suspend='systemctl suspend-then-hibernate'
alias ls='ls --color=auto'
alias ll='lsd -lh'
alias ff='fastfetch'
alias grep='grep --color=auto'
alias cat='bat'
alias c='clear'
alias reload='exec bash'
alias hibernate='systemctl hibernate'
alias erc='nvim ~/.zshrc'
alias zrc='source ~/.zshrc'
alias update='sudo pacman -Syu && yay -Syu'
alias nv='nvim'
alias x='exit'

# Load functions
_load_functions

# -----------------------------------------------------
# Prompt
# -----------------------------------------------------
#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/EDM115-newline.omp.json)"