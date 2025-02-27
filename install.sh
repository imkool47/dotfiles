#!/bin/bash

echo "🔄 Restoring system configuration..."

# Ensure yay is installed
if ! command -v yay &> /dev/null; then
    echo "⚠️ yay not found! Installing yay..."
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd ..
fi

# Update system before installing packages
echo "📦 Updating system..."
sudo pacman -Syu --noconfirm
yay -Syu --noconfirm

# Install official Arch packages (skip already installed ones)
echo "📜 Installing official Arch packages..."
sudo pacman -S --needed - < ~/dotfiles/packages.txt

# Install AUR packages (skip already installed ones)
echo "📜 Installing AUR packages..."
yay -S --needed - < ~/dotfiles/aur-packages.txt

# Restore config files
echo "🛠 Restoring configuration files..."
cp -r ~/dotfiles/config/* ~/.config/

# Restore fonts
echo "🔤 Restoring fonts..."
cp -r ~/dotfiles/fonts/* ~/.local/share/fonts/
fc-cache -fv

echo "✅ Dotfiles restoration complete!"
