#
# Build the components
#

export CC=clang
export CXX=clang++
export RUNTIME_VERSION=gnustep-2.1


#
# Build MAKE the first time
#

echo "BUILDING MAKE ================"

cd git/tools-make
./configure \
    --enable-debug-by-default \
    --with-layout=gnustep \
    --enable-objc-arc \
    --with-library-combo=ng-gnu-gnu
make -j4
sudo -E make install
cd ../..

. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh
echo ". /usr/GNUstep/System/Library/Makefiles/GNUstep.sh" >> ~/.bashrc
echo "export RUNTIME_VERSION=$RUNTIME_VERSION" >> ~/.bashrc


#
# Build libdispatch
#

echo "BUILDING DISPATCH ================"

cd git/swift-corelibs-libdispatch
rm -Rf build
mkdir build && cd build
cmake .. -DCMAKE_C_COMPILER=${CC} \
	-DCMAKE_CXX_COMPILER=${CXX} \
	-DCMAKE_BUILD_TYPE=Release
make
sudo -E make install
sudo ldconfig
cd ../../..

#
# Build  libobjc
#

echo "BUILDING LIBOBJC ================"

cd git/libobjc2
rm -Rf build
mkdir build && cd build
cmake ../ -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_ASM_COMPILER=clang -DTESTS=OFF
cmake --build .
sudo -E make install
sudo ldconfig
cd ../../..


#
# Build MAKE the SECOND time
#

echo "BUILDING MAKE SECOND TIME ================"

cd git/tools-make
./configure \
    --enable-debug-by-default \
    --with-layout=gnustep \
    --enable-objc-arc \
    --with-library-combo=ng-gnu-gnu
make -j4
sudo -E make install
cd ../..

. /usr/GNUstep/System/Library/Makefiles/GNUstep.sh

#
# Build GNUstep Base
#
echo "BUILDING GNUstep Base ================"

cd git/libs-base/
./configure
make -j8
sudo -E make install
cd ../..


#
# Build GNUstep GUI
#
echo "BUILDING GNUstep GUI ================"

cd git/libs-gui/
./configure
make -j8
sudo -E make install
cd ../..

#
# Build GNUstep Back
#
echo "BUILDING GNUstep Back ================"

cd git/libs-back/
./configure
make -j8
sudo -E make install
cd ../..

#
# Build Terminal
#
echo "BUILDING Terminal ================"
cd git/gershwin-terminal
make
sudo -E make install
cd ../..

#
# Build TextEdit
#
echo "BUILDING TextEdit ================"
cd git/gershwin-textedit
make
sudo -E make install
cd ../..

#
# Build Workspace
#
echo "BUILDING GWORKSPACE ================"

cd git/apps-gworkspace
./configure
make -j8
sudo -E make install
cd ../..

#
# Build SystemPreferences
#
echo "BUILDING SYSTEMPREFERENCES ================"

cd git/apps-systempreferences
make -j8
sudo -E make install
cd ../..

#
# Build Libs Steptalk
#
echo "BUILDING LIBS-STEPTALK ================"
cd git/libs-steptalk
make
sudo -E make install
cd ../..

#
# Build RIK Theme
#
echo "BUILDING RIK ================"
cd git/rik.theme
make
sudo -E make install
cd ../..






