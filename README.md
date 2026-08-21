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

Issue 01 intentionally keeps the build setup in one root `CMakeLists.txt`. The generated `build/` directory is ignored and should not be committed.

## Build and test

Configure, build, and test the project:

```bash
cmake -S . -B build
cmake --build build
ctest --test-dir build
```

## Current scope

Issue 01 proves only that a clean CMake configure/build/test path exists. The next task defines content-addressed storage invariants before any core storage implementation begins.
