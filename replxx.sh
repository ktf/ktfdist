package: replxx
version: release-0.0.4
tag: release-0.0.4
source: https://github.com/AmokHuginnsson/replxx
requires:
  - "GCC-Toolchain:(?!osx)"
license: BSD
build_requires:
  - CMake
  - ninja
  - alibuild-recipe-tools
---
#!/bin/bash -e
cmake "$SOURCEDIR"                                    \
  -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE:-RelWithDebInfo} \
  -DCMAKE_INSTALL_PREFIX="$INSTALLROOT"              \
  ${CXXSTD:+-DCMAKE_CXX_STANDARD=$CXXSTD}           \
  -DREPLXX_BUILD_EXAMPLES=OFF                        \
  -G Ninja

cmake --build . -- ${IGNORE_ERRORS:+-k} ${JOBS:+-j $JOBS} install

# Modulefile
MODULEDIR="$INSTALLROOT/etc/modulefiles"
MODULEFILE="$MODULEDIR/$PKGNAME"
mkdir -p "$MODULEDIR"
alibuild-generate-module --bin --lib --root > "$MODULEFILE"
