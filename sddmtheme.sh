#!/bin/bash

# Function to check if a package is installed
is_installed() {
    pacman -Q $1 &>/dev/null
}

# Install SDDM if not installed
if ! is_installed sddm; then
    echo "SDDM is not installed. Installing now..."
    sudo pacman -S --noconfirm sddm
else
    echo "SDDM is already installed."
fi

# Enable and start SDDM
echo "Setting SDDM as the default login manager..."
sudo systemctl enable sddm
sudo systemctl start sddm

# Theme installation directory
THEME_DIR="/usr/share/sddm/themes"

# List of themes
declare -A THEMES
THEMES=(
    ["Candy"]="https://github.com/EliverLara/Sweet-theme/archive/refs/heads/master.zip"
    ["Sequoia"]="https://github.com/sylveon/Sequoia-SDDM/archive/refs/heads/main.zip"
    ["Sugar"]="https://github.com/Aylur/sddm-sugar-candy/archive/refs/heads/main.zip"
)

echo "Available themes:"
select theme in "Candy" "Sequoia" "Sugar" "Exit"; do
    if [[ "$theme" == "Exit" ]]; then
        echo "Exiting..."
        exit 0
    elif [[ -n "$theme" ]]; then
        if [[ -d "$THEME_DIR/$theme" ]]; then
            echo "Theme $theme is already installed."
        else
            echo "Installing $theme theme..."
            TMP_DIR=$(mktemp -d)
            wget -O "$TMP_DIR/theme.zip" "${THEMES[$theme]}"
            sudo unzip "$TMP_DIR/theme.zip" -d "$THEME_DIR"
            sudo mv "$THEME_DIR"/*-*/ "$THEME_DIR/$theme"
            rm -rf "$TMP_DIR"
        fi

        # Apply the theme
        echo "Applying $theme theme..."
        sudo mkdir -p /etc/sddm.conf.d
        echo -e "[Theme]\nCurrent=$theme" | sudo tee /etc/sddm.conf.d/theme.conf >/dev/null

        # Restart SDDM to apply changes
        echo "Restarting SDDM..."
        sudo systemctl restart sddm
        break
    else
        echo "Invalid selection, please choose a valid theme."
    fi
done
