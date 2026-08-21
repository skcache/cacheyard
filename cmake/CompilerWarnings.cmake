include_guard(GLOBAL)

# Apply warnings to one target at a time so this project does not change the
# compiler policy of targets introduced by a dependency later.
function(cacheyard_enable_warnings target)
    if(NOT TARGET "${target}")
        message(FATAL_ERROR "Cannot enable warnings: target '${target}' does not exist")
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
        target_compile_options("${target}" PRIVATE
            -Wall
            -Wextra
            -Wpedantic
        )
    elseif(MSVC)
        target_compile_options("${target}" PRIVATE /W4)
    endif()
endfunction()
