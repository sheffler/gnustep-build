#!/bin/bash
#
# Set up the font system to use IBM Plex for a modern look
#

set -e

curl -OL https://github.com/IBM/plex/releases/download/%40ibm%2Fplex-sans%401.1.0/ibm-plex-sans.zip
curl -OL https://github.com/IBM/plex/releases/download/%40ibm%2Fplex-mono%401.1.0/ibm-plex-mono.zip

unzip ibm-plex-sans.zip
unzip ibm-plex-mono.zip

mkdir -p ~/.fonts

cp ibm-plex-sans/fonts/complete/ttf/* ~/.fonts
cp ibm-plex-mono/fonts/complete/ttf/* ~/.fonts

FONTSIZE=14.0

# set all of the GNUstep defaults
defaults write NSGlobalDomain NSFont IBMPlexSans
defaults write NSGlobalDomain NSFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSLabelFont IBMPlexSans-Medm
defaults write NSGlobalDomain NSLabelFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSBoldFont IBMPlexSans-Bold
defaults write NSGlobalDomain NSBoldFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSMenuFont IBMPlexSans
defaults write NSGlobalDomain NSMenuFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSMessageFont IBMPlexSans-Italic
defaults write NSGlobalDomain NSMessageFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSPaletteFont IBMPlexSans
defaults write NSGlobalDomain NSPaletteFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSTitleBarFont IBMPlexSans-Medm
defaults write NSGlobalDomain NSTitleBarFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSToolTipsFont IBMPlexSans-LightItalic
defaults write NSGlobalDomain NSToolTipsFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSControlContentFont IBMPlexSans
defaults write NSGlobalDomain NSControlContentFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSUserFont IBMPlexSans
defaults write NSGlobalDomain NSUserFixedPitchFontSize ${FONTSIZE}

defaults write NSGlobalDomain NSUserFixedPitchFont IBMPlexMono
defaults write NSGlobalDomain NSUserFontSize ${FONTSIZE}

