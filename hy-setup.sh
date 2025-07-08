#!/bin/bash

# Hyprland Setup Script for Arch Linux Minimal Install (Zsh, Foot, Ghostty, Hyprshade version)

set -e

echo "🔄 Updating system..."
sudo pacman -Syu --noconfirm

echo "📆 Installing core system and Hyprland packages..."
sudo pacman -S --noconfirm \
  hyprland \
  xdg-desktop-portal \
  xdg-desktop-portal-hyprland \
  qt5-wayland qt6-wayland \
  gtk3 gtk4 gnome-themes-extra \
  waybar \
  rofi-wayland \
  dunst \
  hyprpaper \
  hyprpicker \
  grim slurp wf-recorder swappy \
  pipewire pipewire-audio pipewire-pulse wireplumber \
  pavucontrol alsa-utils \
  brightnessctl acpi \
  libinput \
  fcitx5 fcitx5-im fcitx5-configtool fcitx5-gtk fcitx5-qt \
  polkit-gnome \
  gvfs \
  thunar thunar-archive-plugin file-roller \
  xdg-utils \
  network-manager-applet nm-connection-editor \
  foot \
  seatd \
  qt5ct kvantum-qt5 lxappearance \
  unzip git \
  zsh zsh-completions fzf \
  cargo \
  tmux

echo "✅ Installation complete!"
echo "💡 Don't forget to set zsh as your default shell:"
echo "    chsh -s /bin/zsh"
