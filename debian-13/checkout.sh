#!/bin/sh

set -e

REPOS="
https://github.com/gnustep/libobjc2.git
https://github.com/apple/swift-corelibs-libdispatch
https://github.com/gnustep/tools-make.git
https://github.com/gnustep/libs-base.git
https://github.com/gnustep/libs-gui.git
https://github.com/gnustep/libs-back.git
https://github.com/gnustep/libs-steptalk.git
https://github.com/gnustep/apps-gworkspace.git
https://github.com/gnustep/apps-systempreferences.git
https://github.com/mclarenlabs/rik.theme.git
https://github.com/gershwin-desktop/gershwin-terminal.git
https://github.com/gershwin-desktop/gershwin-textedit.git
"

mkdir -p git
cd git

for REPO in $REPOS; do
    NAME=$(basename "$REPO" .git)
    if [ -d "$NAME/.git" ]; then
        echo "Updating $NAME..."
        cd "$NAME"
        git pull --ff-only
        cd ..
    else
        echo "Cloning $NAME..."
        git clone "$REPO"
    fi
done




  
