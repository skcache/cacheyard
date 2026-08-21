add_executable(cacheyard_tests bootstrap_test.cpp)
target_link_libraries(cacheyard_tests PRIVATE cacheyard_core)

if(CACHEYARD_ENABLE_WARNINGS)
    cacheyard_enable_warnings(cacheyard_tests)
endif()

if(CACHEYARD_ENABLE_SANITIZERS)
    cacheyard_enable_sanitizers(cacheyard_tests)
endif()

add_test(NAME cacheyard.bootstrap COMMAND cacheyard_tests)
