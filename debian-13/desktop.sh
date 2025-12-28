#!/bin/bash
#
# Install a desktop file for a minimal GNUstep environment
#  - window manager
#  - gworkspace
#  - terminal
#
# Notes:
#   X-GDM-SessionRegisters
#     true: The session handles its own registration (typical for full desktop
#       environments like GNOME, KDE, GNUstep)
#     false or omitted: GDM will handle registration itself (typical for
#       simple window managers like i3, openbox)

cat > gnustep.desktop <<EOF
[Desktop Entry]
Name=GNUstep
Comment=This session logs you into GNUstep
Exec=/usr/bin/gnustep-session
TryExec=/usr/bin/gnustep-session
Type=Application
DesktopNames=GNUstep
X-GDM-SessionRegisters=false
EOF

sudo mv gnustep.desktop /usr/share/xsessions

cat > gnustep-session <<EOF
#!/bin/sh

. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh

xfwm4 &
openapp Terminal &
sleep 1 && openapp GWorkspace
EOF

chmod +x gnustep-session

sudo mv gnustep-session /usr/bin

#
# Set Defaults appropriate for the XFWM4 window manager
#
defaults write NSGlobalDomain GSSuppressAppIcon YES
defaults write NSGlobalDomain GSAppOwnsMiniwindow NO
