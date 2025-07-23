#!/bin/bash

set -e

INSTLOG="install.log"
exec > >(tee -a "$INSTLOG") 2>&1

# Check if yay is installed
if ! command -v yay &>/dev/null; then
  echo "Installing yay..."
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

# Official packages
PACMAN_PACKAGES=(
    wget
    unzip
    rsync
    git
    foot
    xdg-user-dirs
    hyprland
    hyprpaper
    hypridle
    hyprlock
    hyprpicker
    hyprutils
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts-extra
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    libnotify
    qt5-wayland
    qt6-wayland
    fastfetch
    thunar
    thunar-archive-plugin
    file-roller
    python
    python-pip
    python-gobject
    brightnessctl
    nm-connection-editor
    network-manager-applet
    gtk4
    libadwaita
    fuse2
    imagemagick
    jq
    lsd
    neovim
    btop
    bluez
    bluez-utils
    blueman
    grim
    slurp
    cliphist
    qt6ct
    qt5-svg
    qt5-quickcontrols2
    qt5-graphicaleffects
    waybar
    rofi-wayland
    polkit-gnome
    zsh
    zsh-completions
    cargo
    fzf
    wf-recorder
    swappy
    pipewire
    pipewire-audio
    pipewire-pulse
    wireplumber
    pavucontrol
    alsa-utils
    brightnessctl
    acpi
    papirus-icon-theme
    breeze
    flatpak
    swaync
    gvfs
    power-profiles-daemon
    seatd
    libinput
    lxappearance
    pacman-contrib
    fd
    ripgrep
    sddm
    nodejs
    npm
    reflector
    tmux
)

# AUR packages
AUR_PACKAGES=(
    ghostty
    grimblast-git
    bibata-cursor-theme-bin
    otf-font-awesome
    ttf-fira-sans
    ttf-fira-code
    ttf-firacode-nerd
    ttf-dejavu
    ttf-jetbrains-mono-nerd
    checkupdates-with-aur
    loupe
    hyprshade
    zen-browser-bin
    oh-my-posh-bin
    wlogout
    vlc
)

# Install official packages
for pkg in "${PACMAN_PACKAGES[@]}"; do
  if ! pacman -Qq "$pkg" &>/dev/null; then
    echo "Installing $pkg..."
    sudo pacman -S "$pkg" --noconfirm
  else
    echo "$pkg is already installed."
  fi
done

# Install AUR packages
for pkg in "${AUR_PACKAGES[@]}"; do
  if ! pacman -Qq "$pkg" &>/dev/null; then
    echo "Installing AUR package: $pkg..."
    yay -S "$pkg" --noconfirm
  else
    echo "$pkg is already installed."
  fi
done

# Remove conflicting portals
for portal in xdg-desktop-portal-gnome xdg-desktop-portal-gtk; do
  if pacman -Qq "$portal" &>/dev/null; then
    echo "Removing conflicting portal: $portal..."
    yay -R --noconfirm "$portal"
  fi
done

# Install Oh My Zsh (unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Setup oh-my-zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ]; then
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
fi

# Copy custom configuration files if present in script directory
if [ -d "confs" ]; then
  echo "Copying dotfiles..."
  cp confs/.zshrc ~/
  cp confs/.gtkrc-2.0 ~/

  echo "Creating config directories from confs/..."
  find confs -type d -not -path "confs" | while read -r dir; do
    mkdir -p "$HOME/.config/${dir#confs/}"
  done

  echo "Copying config files to ~/.config (excluding dotfiles)..."
  rsync -av --exclude='.zshrc' --exclude='.gtkrc-2.0' --exclude='.*' confs/ "$HOME/.config/"

  cp /usr/share/oh-my-posh/themes/*.json ~/.config/ohmyposh/
fi

# Enabling services
sudo systemctl enable sddm.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now power-profiles-daemon.service

# Create a drop-in override for systemd sleep settings
echo "Creating sleep.conf.d override for suspend-then-hibernate..."
sudo mkdir -p /etc/systemd/sleep.conf.d
sudo tee /etc/systemd/sleep.conf.d/00-suspend-then-hibernate.conf > /dev/null <<EOF
[Sleep]
AllowSuspendThenHibernate=yes
HibernateDelaySec=30min
SuspendState=mem
HibernateMode=platform shutdown
EOF

# Disable aggressive power saving
echo "Disable power saving"
sudo tee /etc/modprobe.d/iwlwifi.conf > /dev/null <<EOF
options iwlwifi power_save=0
EOF

sudo tee /etc/NetworkManager/conf.d/wifi-powersave-off.conf <<EOF
[connection]
wifi.powersave = 2
EOF
sudo systemctl restart NetworkManager


echo "✅ Installation complete!"
echo "💡 Don't forget to set zsh as your default shell:"
echo " chsh -s /bin/zsh"
