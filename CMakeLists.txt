cmake_minimum_required(VERSION 3.20)

project(cacheyard VERSION 0.1.0 LANGUAGES CXX)

include(CTest)

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
