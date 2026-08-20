cmake_minimum_required(VERSION 3.20)

project(cacheyard VERSION 0.1.0 LANGUAGES CXX)

include(CTest)

option(CACHEYARD_ENABLE_WARNINGS "Enable useful compiler warnings" ON)
option(CACHEYARD_ENABLE_SANITIZERS "Enable AddressSanitizer and UBSan" OFF)

set(CMAKE_CXX_EXTENSIONS OFF)

if(CACHEYARD_ENABLE_WARNINGS)
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

if(CACHEYARD_ENABLE_SANITIZERS)
    if(NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
        message(FATAL_ERROR "CACHEYARD_ENABLE_SANITIZERS requires Clang or GNU C++")
    endif()

    add_compile_options(-fsanitize=address,undefined -fno-omit-frame-pointer)
    add_link_options(-fsanitize=address,undefined)
endif()

add_library(cacheyard_core STATIC
    src/bootstrap.cpp
)

target_compile_features(cacheyard_core PUBLIC cxx_std_20)
target_include_directories(cacheyard_core
    PUBLIC
        "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

add_executable(cacheyard
    src/main.cpp
)
target_link_libraries(cacheyard PRIVATE cacheyard_core)

add_executable(cacheyard_tests
    tests/bootstrap_test.cpp
)
target_link_libraries(cacheyard_tests PRIVATE cacheyard_core)

if(BUILD_TESTING)
    add_test(NAME cacheyard.bootstrap COMMAND cacheyard_tests)
endif()
