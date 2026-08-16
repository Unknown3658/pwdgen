#ifndef CLI_H
#define CLI_H

#include <cstddef>
#include <optional>
#include <string_view>

struct CliArgs {
    std::size_t length = 16;
    std::size_t count = 1;
    bool lower = true;
    bool upper = true;
    bool digits = true;
    bool symbols = true;
};

[[nodiscard]] std::optional<CliArgs> parseArgs(int argc, char* argv[]);

#endif // CLI_H
