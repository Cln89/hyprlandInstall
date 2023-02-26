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
git clone https://aur.archlinux.org/yay-bin
cd yay-bin || exit

# MAKE SURE YOU ARE THE OWNER OF YAY-BIN (check using ls -al)
# IF YOU'RE NOT THE OWNER:
#chown username: yay-bin/ -R

makepkg -si

# We no longer need the yay-bin directory as it has already been installed on our system, we can remove it like so:
rm -rf yay-bin/

# ====={ Install }=====
# Install the following packages:
# Environment: hyprland-bin, polkit-gnome, swaylock-effects, dunst,
#              sddm-git, nwg-look-bin, nordic-theme, papirus-icon-theme
# Utilities: ffmpeg, neovim, viewnior, rofi, pavucontrol, thunar,
#            starship, wl-clipboard, wf-recorder, swaybg, grimblast-git,
#            ffmpegthumbnailer, tumbler, playerctl, noise-suppression-for-voice,
#            thunar-archive-plugin, kitty, waybar-hyprland, wlogout, pamixer
yay -S hyprland-bin polkit-gnome ffmpeg neovim viewnior       \
rofi pavucontrol thunar starship wl-clipboard wf-recorder     \
swaybg grimblast-git ffmpegthumbnailer tumbler playerctl      \
noise-suppression-for-voice thunar-archive-plugin kitty       \
waybar-hyprland wlogout swaylock-effects sddm-git pamixer     \
nwg-look-bin nordic-theme papirus-icon-theme dunst

yay Syu # Check for updates like `apt get update`

reboot

# ====={ Configure LightDM }=====

nano /etc/lightdm/lightdm.conf

# Uncomment and change:
# > user-session=hyprland
# > auto-login-session=hyprland
# > auto-login-user=username

sudo groupadd autologin
usermod -aG autologin username

sudo systemctl enable lightdm

# Check if your sys control default is graphical
sudo systemctl get-default

# If not graphical
sudo systemctl set-default graphical.target

reboot

# You should see a login GUI when rebooted

# ====={ Download dotfiles (configuration stuff) }=====

git clone https://github.com/ChrisTitusTech/hyprland-titus%60
rename .config/ .tempconfig/ .config/
mv hyprland-titus/dotfiles/.config/ ./

git clone https://github.com/linuxmobile/hyprland-dots
mv hyprland-dots/.local ./

reboot

# ====={ .env vars }=====

export WLR_RENDERER_ALLOW_SOFTWARE=1

# ====={ hyprctl }===== https://youtu.be/sDmLCBI9L4E?t=4573
hyprctl

# ====={ wlogout }===== wlogout is a simple Wayland logout menu for sway. It is a fork of swaylock-effects with the addition of a logout menu.
git clone https://github.com/ArtsyMacaw/wlogout.git
cd wlogout || exit
meson build
ninja -C build
sudo ninja -C build install