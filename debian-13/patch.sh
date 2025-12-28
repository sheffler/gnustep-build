#!/bin/bash
#
# Apply Debian-13 specific patches
#


#
# PATCH GERSHWiN-TERMINAL
#

cd git/gershwin-terminal

cat > changes.patch <<EOF
diff --git a/GNUmakefile.preamble b/GNUmakefile.preamble
index 19ac603..24a7ba9 100644
--- a/GNUmakefile.preamble
+++ b/GNUmakefile.preamble
@@ -23,4 +23,4 @@ ADDITIONAL_LIB_DIRS +=
 # Additional GUI libraries to link
 ADDITIONAL_GUI_LIBS += 
 
-ADDITIONAL_LDFLAGS += -liconv -lutil
+ADDITIONAL_LDFLAGS += -lutil
EOF

# Apply the patch
git apply changes.patch 

cd ../..
