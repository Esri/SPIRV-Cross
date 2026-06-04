#!/usr/bin/env bash
set -ex

rm -rf build
rm -rf install
rm -f *.zip

SPIRV_CROSS_VERSION=1.3.261.1_3
export DEVELOPER_DIR="/Applications/Xcode_16.2.0.app/Contents/Developer"
PATH="/usr/local/rtc/cmake/4.2.1/bin:/usr/local/rtc/ninja/1.12.1/bin:$PATH"
ESRI_PATH="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

cd "${ESRI_PATH}"
cmake -S .. -B build/arm64 \
  -GNinja \
  -DCMAKE_OSX_SYSROOT=macosx \
  -DCMAKE_OSX_ARCHITECTURES="arm64" \
  -DCMAKE_SYSTEM_PROCESSOR="arm64" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="14.0" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=install/arm64/${SPIRV_CROSS_VERSION} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build/arm64 --target install/strip
cd install/arm64
zip -r ../../spirv-cross-${SPIRV_CROSS_VERSION}-arm64.zip ${SPIRV_CROSS_VERSION}

cd "${ESRI_PATH}"
arch -x86_64 cmake -S .. -B build/x86_64 \
  -GNinja \
  -DCMAKE_OSX_SYSROOT=macosx \
  -DCMAKE_OSX_ARCHITECTURES="x86_64" \
  -DCMAKE_SYSTEM_PROCESSOR="x86_64" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="14.0" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=install/x86_64/${SPIRV_CROSS_VERSION} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build/x86_64 --target install/strip
cd install/x86_64
zip -r ../../spirv-cross-${SPIRV_CROSS_VERSION}-x86_64.zip ${SPIRV_CROSS_VERSION}
