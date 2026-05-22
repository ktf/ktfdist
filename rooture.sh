package: rooture
version: v0.0.0
source: https://github.com/ktf/rooture
requires:
- ROOT
- replxx
- tree-sitter
build_requires:
- Xcode:(?!osx)
- CMake
- ninja
---

cmake $SOURCEDIR                                                                                                \
      -DCMAKE_INSTALL_PREFIX=$INSTALLROOT                                                                       \
      -G Ninja                                                                                                 \

cp ${BUILDDIR}/compile_commands.json ${INSTALLROOT}

cmake --build . -- -k 0 ${JOBS:+-j$JOBS} install
