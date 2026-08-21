# Cacheyard

Cacheyard is a learning-first C++20 distributed content-addressed artifact cache. The repository is currently at Issue 01: the build graph is in place, but storage, HTTP, hashing, concurrency, and distributed behavior have not been implemented yet.

## Build graph

The first task intentionally keeps the graph small:

```text
cacheyard_core (static library)
├── cacheyard       (executable)
└── cacheyard_tests (executable registered with CTest)
```

Both executables link to `cacheyard_core`. There are no third-party dependencies yet; the compiler supplies the normal C++ runtime and standard library.

The CMake structure follows the same ownership boundaries as the graph:

```text
CMakeLists.txt          project policy and subdirectory orchestration
cmake/                  reusable warning and sanitizer helpers
src/CMakeLists.txt      library and application targets
tests/CMakeLists.txt    test target and CTest registration
```

`src/` is a source directory, not a build directory. Configure from the repository root with `cmake -S . -B <build-dir>` so generated files stay in an ignored out-of-source build tree.

## Build and test

Configure and build the default tree:

```bash
cmake -S . -B build
cmake --build build
ctest --test-dir build --output-on-failure
```

Build both configurations from clean trees:

```bash
cmake -S . -B build-debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build-debug
ctest --test-dir build-debug --output-on-failure

cmake -S . -B build-release -DCMAKE_BUILD_TYPE=Release
cmake --build build-release
ctest --test-dir build-release --output-on-failure
```

Debug builds preserve debugger-friendly behavior and symbols. Release builds enable the compiler's optimization profile. The target graph and source-level behavior are otherwise the same.

Optional sanitizer scaffolding is available for later tasks:

```bash
cmake -S . -B build-asan -DCMAKE_BUILD_TYPE=Debug -DCACHEYARD_ENABLE_SANITIZERS=ON
cmake --build build-asan
ctest --test-dir build-asan --output-on-failure
```

To inspect the actual compile and link commands while learning:

```bash
cmake --build build-debug --verbose
```

## Current scope

Issue 01 proves only that a clean CMake configure/build/test path exists. The next task defines content-addressed storage invariants before any core storage implementation begins.
