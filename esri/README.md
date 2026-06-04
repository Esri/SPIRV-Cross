
# How to build for runtimecore

Update the version of compilers, cmake, and ninja in the scripts.

- SPIRV-Cross 1.3.261.1
- llvm 19.1.2
- CMake 4.2.1
- Ninja 1.12.1
- Xcode 16.2.0
- Visual Studio 2026 toolchain version 14.44.35207
- Windows SDK 10.0.19041.0

## linux

```bash
cd esri
./build_spirv-cross_linux.sh
```

## macos

```bash
cd esri
./build_spirv-cross_macos.sh
```

## windows

```bash
cd esri
./build_spirv-cross_windows.sh
```

Copy the generated spirv-cross zip file to the network shares
