#!/bin.sh
# ====={ Install Arch }=====
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