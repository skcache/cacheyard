add_library(cacheyard_core STATIC bootstrap.cpp)

target_compile_features(cacheyard_core PUBLIC cxx_std_20)
target_include_directories(cacheyard_core
    PUBLIC
        "${PROJECT_SOURCE_DIR}/include"
)

if(CACHEYARD_ENABLE_WARNINGS)
    cacheyard_enable_warnings(cacheyard_core)
endif()

if(CACHEYARD_ENABLE_SANITIZERS)
    cacheyard_enable_sanitizers(cacheyard_core)
endif()

add_executable(cacheyard main.cpp)
target_link_libraries(cacheyard PRIVATE cacheyard_core)

if(CACHEYARD_ENABLE_WARNINGS)
    cacheyard_enable_warnings(cacheyard)
endif()

if(CACHEYARD_ENABLE_SANITIZERS)
    cacheyard_enable_sanitizers(cacheyard)
endif()
