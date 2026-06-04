#!/usr/bin/env bash
set -ex

rm -rf build
rm -rf install
rm -f *.zip

SPIRV_CROSS_VERSION=1.3.261.1_3
export CC="/usr/local/rtc/llvm/19.1.2/bin/clang"
export CXX="/usr/local/rtc/llvm/19.1.2/bin/clang++"
PATH="/usr/local/rtc/cmake/4.2.1/bin:/usr/local/rtc/ninja/1.12.1/bin:$PATH"
ESRI_PATH="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

cd "${ESRI_PATH}"
cmake -S .. -B build/aarch64 \
  -GNinja \
  -DCMAKE_SYSROOT=/usr/local/rtc/sysroot/redhat8.4/aarch64 \
  -DCMAKE_C_COMPILER_TARGET=aarch64-unknown-linux-gnu \
  -DCMAKE_CXX_COMPILER_TARGET=aarch64-unknown-linux-gnu \
  -DCMAKE_C_FLAGS="-stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_CXX_FLAGS="-stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_SHARED_LINKER_FLAGS="-stdlib=libc++ -static-libstdc++ -fuse-ld=lld -rtlib=compiler-rt -ldl -pthread" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=install/aarch64/${SPIRV_CROSS_VERSION} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build/aarch64 --target install/strip
cd install/aarch64
zip -r ../../spirv-cross-${SPIRV_CROSS_VERSION}-aarch64.zip ${SPIRV_CROSS_VERSION}

cd "${ESRI_PATH}"
cmake -S .. -B build/x86_64 \
  -GNinja \
  -DCMAKE_SYSROOT=/usr/local/rtc/sysroot/redhat8.4/x86_64 \
  -DCMAKE_C_COMPILER_TARGET=x86_64-unknown-linux-gnu \
  -DCMAKE_CXX_COMPILER_TARGET=x86_64-unknown-linux-gnu \
  -DCMAKE_C_FLAGS="-m64 -stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_CXX_FLAGS="-m64 -stdlib=libc++ -fuse-ld=lld -rtlib=compiler-rt" \
  -DCMAKE_SHARED_LINKER_FLAGS="-stdlib=libc++ -static-libstdc++ -rtlib=compiler-rt -ldl -pthread" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=install/x86_64/${SPIRV_CROSS_VERSION} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build/x86_64 --target install/strip
cd install/x86_64
zip -r ../../spirv-cross-${SPIRV_CROSS_VERSION}-x86_64.zip ${SPIRV_CROSS_VERSION}
