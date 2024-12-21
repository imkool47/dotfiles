
## <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Arch_Linux_%22Crystal%22_icon.svg/256px-Arch_Linux_%22Crystal%22_icon.svg.png" alt="Arch Logo" width="24"> 

# Dotfiles for Arch Linux with Hyprland

Welcome to my dotfiles repository! This is where I store my personal configurations for Arch Linux with Hyprland and other tools I use daily. Feel free to explore, fork, or use them as inspiration for your own setup.

![Header](https://raw.githubusercontent.com/imkool47/dotfiles/refs/heads/main/Screenshots/DittoDotsHeader.jpg)

## Features
- **Hyprland**: Tiling window manager configuration with a sleek and minimal look.
- **Waybar**: Customizable status bar with themes.
- **Kitty**: Configured for speed and aesthetics.
- **Neovim**: Plugin-rich configuration using `lazy.nvim`.
- **Fastfetch**: Display system info with a beautiful logo.
- **Rofi/Wofi**: Application launchers with custom themes.
- **SDDM**: A visually appealing login manager.

---

## Screenshots

### Desktop Setup

### Kitty (Fish, Starship and Pokeget Setup)
![Desktop Screenshot](https://raw.githubusercontent.com/imkool47/dotfiles/refs/heads/main/Screenshots/2024-12-12-175854_hyprshot.png)

### Btop
![btop](https://raw.githubusercontent.com/imkool47/dotfiles/refs/heads/main/Screenshots/2024-12-12-184352_hyprshot.png)

### Neovim with Plugins
![Neovim](https://raw.githubusercontent.com/imkool47/dotfiles/refs/heads/main/Screenshots/2024-12-12-180108_hyprshot.png)

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/imkool47/dotfiles.git
   cd dotfiles
   ```

2. **Backup Existing Configurations**:
   Ensure you back up your current configuration files:
   ```bash
   mv ~/.config ~/.config.backup
   ```

3. **Install Dependencies**:
   Install the necessary packages for your setup:
   ```bash
   sudo pacman -S kitty neovim
   ```
   ```bash
   yay -S cava brightnessctl fish hyprland hyprlock hyprpaper hyprpicker hyprshot hyprshade waybar rofi wlogout swaync pywal pywalfox waypaper wofi rofi starship yazi swww pipes.sh cbonsai cliphist
   ```
5. **Link the Configurations**:
   Symlink the configurations to your home directory:
   ```bash
   ln -s ~/dotfiles/* ~/.config/
   ```

---

## File Structure

```plaintext
.
├── fastfetch/
├── hypr/
├── kitty/
├── nvim/
├── rofi/
├── swaync/
├── waybar/
├── wlogout/
└── assets/
```

- **fastfetch/**: Configuration for system info.
- **hypr/**: Hyprland-specific settings and scripts.
- **kitty/**: Terminal emulator configuration.
- **nvim/**: Neovim setup.
- **waybar/**: Status bar theme and modules.
- **assets/**: Images used in this `README.md`.

---

## Contributing
Feel free to submit pull requests or open issues if you have suggestions to improve these dotfiles.

---

Enjoy your personalized Arch Linux setup! 🌟
