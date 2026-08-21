include_guard(GLOBAL)

# Static libraries have no link step of their own, but their object files must
# still be instrumented. The executable targets link the sanitizer runtime.
function(cacheyard_enable_sanitizers target)
    if(NOT TARGET "${target}")
        message(FATAL_ERROR "Cannot enable sanitizers: target '${target}' does not exist")
    endif()

    if(NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
        message(FATAL_ERROR "CACHEYARD_ENABLE_SANITIZERS requires Clang or GNU C++")
    endif()

    target_compile_options("${target}" PRIVATE
        -fsanitize=address,undefined
        -fno-omit-frame-pointer
    )

    get_target_property(target_type "${target}" TYPE)
    if(NOT target_type STREQUAL "STATIC_LIBRARY"
       AND NOT target_type STREQUAL "OBJECT_LIBRARY")
        target_link_options("${target}" PRIVATE
            -fsanitize=address,undefined
        )
    endif()
endfunction()
