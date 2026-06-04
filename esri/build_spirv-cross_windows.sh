#!/usr/bin/env bash
set -ex

rm -rf build
rm -rf install
rm -f *.zip

SPIRV_CROSS_VERSION=1.3.261.1_3
export GENERATOR="Visual Studio 18 2026"
export TOOLSET="version=14.50.35717"
export WINDOWS_SDK_VERSION="10.0.19041.0"
PATH="/c/rtc/cmake/4.2.1/bin:${PATH}"
ESRI_PATH="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

cd "${ESRI_PATH}"
cmake -S .. -B build/arm64 \
  -G"${GENERATOR}" \
  -T"${TOOLSET}" \
  -A ARM64 \
  -DCMAKE_SYSTEM_VERSION=${WINDOWS_SDK_VERSION} \
  -DCMAKE_INSTALL_PREFIX=install/arm64/${SPIRV_CROSS_VERSION} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build/arm64 --config Release --target INSTALL
cd install/arm64
powershell.exe Compress-Archive ${SPIRV_CROSS_VERSION} ../../spirv-cross-${SPIRV_CROSS_VERSION}-arm64.zip

cd "${ESRI_PATH}"
cmake -S .. -B build/x86_64 \
  -G"${GENERATOR}" \
  -T"${TOOLSET}" \
  -A x64 \
  -DCMAKE_SYSTEM_VERSION=${WINDOWS_SDK_VERSION} \
  -DCMAKE_INSTALL_PREFIX=install/x86_64/${SPIRV_CROSS_VERSION} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build/x86_64 --config Release --target INSTALL
cd install/x86_64
powershell.exe Compress-Archive ${SPIRV_CROSS_VERSION} ../../spirv-cross-${SPIRV_CROSS_VERSION}-x86_64.zip
