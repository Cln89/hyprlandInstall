#!/bin.sh
# ====={ Install Arch }=====
# Open ISO Arch
# Select:
# New User with root
# Drive: partition (look it up) ext4
# Optional repos: Multilib
# Software firefox
# Swap: No
# Root password: duh
# Desktop profile, sway
# Network configuration: NetworkManager

# Install...

# ====={ Dependencies for package manager }=====

pacman -S git
git clone https://aur.archlinux.org/paru-bin
cd paru-bin || exit

# MAKE SURE YOU ARE THE OWNER OF YAY-BIN (check using ls -al)
# IF YOU'RE NOT THE OWNER:
#chown username: paru-bin/ -R
pacman -Syu base-devel --noconfirm # Install base-devel, without confirmation. This is required for makepkg to work.
makepkg -si --noconfirm # Install paru, without confirmation. This will be your new package manager.
cd ../ || exit # Go back to the parent directory

rm -rf paru-bin # Remove the paru-bin directory, and all of its contents. As we no longer need it.

# Sets the default target to graphical.target, if it wasn't set already.
if [ $(systemctl get-default) != "graphical.target" ] ;
    then systemctl set-default graphical.target;
fi
# ====={ Install }=====
# Install the following packages:
# Environment: hyprland-bin, polkit-gnome, swaylock-effects, dunst,
#              sddm-git, nwg-look-bin, nordic-theme, papirus-icon-theme
# Utilities: ffmpeg, neovim, viewnior, rofi, pavucontrol, thunar,
#            starship, wl-clipboard, wf-recorder, swaybg, grimblast-git,
#            ffmpegthumbnailer, tumbler, playerctl, noise-suppression-for-voice,
#            thunar-archive-plugin, kitty, waybar-hyprland, wlogout, pamixer
paru hyprland-bin polkit-gnome ffmpeg neovim viewnior       \
rofi pavucontrol thunar starship wl-clipboard wf-recorder     \
swaybg grimblast-git ffmpegthumbnailer tumbler playerctl      \
noise-suppression-for-voice thunar-archive-plugin kitty       \
waybar-hyprland wlogout swaylock-effects sddm-git pamixer     \
nwg-look-bin nordic-theme papirus-icon-theme dunst meson      \
ninja firefox

paru # Check for updates like `apt get update`

# reboot

# ====={ Configure SDDM }=====
# nano /etc/sddm/sddm.cfg

# Uncomment and change:
# > user-session=hyprland
# > auto-login-session=hyprland
# > auto-login-user=username

sudo groupadd autologin
usermod -aG autologin username

sudo systemctl enable sddm

#sudo systemctl get-default

# If not graphical
#sudo systemctl set-default graphical.target

# You should see a login GUI when rebooted

# ====={ Download dotfiles (configuration stuff) }=====

rename .config/ .tempconfig/ .config/
mv hyprland-script/dotconfig/.config/ ./

git clone https://github.com/linuxmobile/hyprland-dots
mv hyprland-dots/.local ./

#reboot

# ====={ .env vars }=====

export WLR_RENDERER_ALLOW_SOFTWARE=1

# ====={ hyprctl }===== https://youtu.be/sDmLCBI9L4E?t=4573
# maybe use hyperctl later for more configuration
#hyprctl

# ====={ wlogout }===== wlogout is a simple Wayland logout menu for sway. It is a fork of swaylock-effects with the addition of a logout menu.
git clone https://github.com/ArtsyMacaw/wlogout.git
cd wlogout || exit
meson build
ninja -C build
sudo ninja -C build install
