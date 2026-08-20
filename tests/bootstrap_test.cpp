#include "cacheyard/bootstrap.hpp"

#include <iostream>
#include <string_view>

int main() {
    constexpr std::string_view expected_name = "cacheyard";
    if (cacheyard::project_name() != expected_name) {
        std::cerr << "unexpected project name\n";
        return 1;
    }

    return 0;
}
