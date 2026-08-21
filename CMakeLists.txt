cmake_minimum_required(VERSION 3.20)

project(cacheyard VERSION 0.1.0 LANGUAGES CXX)

# Keep compiler extensions out of the public build contract. Targets still
# request the language level they need with target_compile_features().
set(CMAKE_CXX_EXTENSIONS OFF)

include(CTest)

option(CACHEYARD_ENABLE_WARNINGS "Enable useful compiler warnings" ON)
option(CACHEYARD_ENABLE_SANITIZERS "Enable AddressSanitizer and UBSan" OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(CompilerWarnings)
include(Sanitizers)

add_subdirectory(src)

if(BUILD_TESTING)
    add_subdirectory(tests)
endif()
