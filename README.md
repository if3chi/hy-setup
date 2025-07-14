## Hyprland Auto Setup Script

This script sets up a full Wayland-based Hyprland environment on Arch Linux.

## ⚙️ Features

- 🔲 **Hyprland** Wayland compositor
- 🖥️ **Ghostty** as default terminal, Foot fallback
- 🧩 Preconfigured **Waybar**, **swaync** with blur + Adwaita-dark theme
- 🎨 GTK theming, Papirus icons, Bibata cursor
- ⚙️ **Zsh** shell with **Oh My Zsh** + plugins + **Oh My Posh**
- 📁 Thunar file manager, Loupe image viewer
- 🧰 Developer essentials: Neovim, Git, Node.js, Python, VS Code
- 🔊 Pipewire, Bluetooth, Power profiles, Notifications
- 🔍 Tools like `fastfetch`, `btop`, `fd`, `ripgrep`, `fzf`, and more
- 🌐 Zen browser (AUR), Flatpak support, AUR helpers included


## 📦 Package Summary

- **Official**: `hyprland`, `waybar`, `swaync`, `ghostty`, `neovim`, `foot`, `blueman`, `zsh`, `btop`, `fzf`, etc.
- **AUR**: `ghostty`, `zen-browser-bin`, `hyprshade`, `oh-my-posh-bin`, `bibata-cursor-theme-bin`, fonts, etc.



### 📁 Directory Layout
- `config/`: Custom config files for `.config`
- `config/.zshrc`, `.gtkrc-2.0`: Dotfiles placed in `$HOME`

### 🚀 Usage
```bash
chmod +x install.sh
./install.sh
```

### 🧪 Notes
- If `yay` is not installed, it gets built from AUR.
- Script logs output to `install.log`
- Restarts not automated — reboot manually after install

### ✅ After Install
- Set ZSH as default shell:
```bash
chsh -s /bin/zsh
```
- Reboot:
```bash
reboot
```

---
Enjoy your custom Hyprland setup! 🎨