#include <cstdlib>
#include <stdexcept>
#include "cli.h"
#include <iostream>
#include <string_view>

static void printUsage() {
    std::cout << "Password Generator (pwdgen)\n"
              << "\n"
              << "Usage: pwdgen [options]\n"
              << "\n"
              << "Generates a random password using a cryptographically secure random number generator (CSPRNG).\n"
              << "\n"
              << "Default: 16 character password with all character types.\n"
              << "\n"
              << "Options:\n"
              << "  -h     Show this help message\n"
              << "  -l N   Password length (16 <= N <= 256, default 16)\n"
              << "  -c M   Number of passwords (M > 1, default 1)\n"
              << "  -nl    Exclude lowercase letters\n"
              << "  -nu    Exclude uppercase letters\n"
              << "  -nd    Exclude digits\n"
              << "  -ns    Exclude symbols\n"
              << "\n"
              << "Examples:\n"
              << "  pwdgen                         # 16 character password with all character types\n"
              << "  pwdgen -l 32 -c 3              # 3 passwords of 32 characters\n"
              << "  pwdgen -l 20 -nl -nd           # Only letters and symbols (20 characters)\n"
              << "  pwdgen -l 32 -nu -nd -ns -c 5  # Lowercase only (5 passwords)\n";
}

[[nodiscard]] std::optional<CliArgs> parseArgs(int argc, char* argv[]) {
    CliArgs args;
    for (int i = 1; i < argc; ++i) {
        std::string_view arg = argv[i];
        if (arg == "--help" || arg == "-h") {
            printUsage();
            std::exit(0);
        } else if (arg[0] == '-') {
            // Короткие флаги
            if (arg == "-l") {
                if (i + 1 >= argc) {
                    std::cerr << "Error: -l requires a value\n";
                    return std::nullopt;
                }
                char* endptr = nullptr;
                unsigned long parsed = std::strtoul(argv[++i], &endptr, 10);
                if (*endptr != '\0') {
                    std::cerr << "Error: invalid length value\n";
                    return std::nullopt;
                }
                args.length = static_cast<std::size_t>(parsed);
                if (args.length < 16) {
                    std::cerr << "Error: -l must be >= 16\n";
                    return std::nullopt;
                }
                if (args.length > 256) {
                    std::cerr << "Error: -l must be <= 256\n";
                    return std::nullopt;
                }
            } else if (arg == "-c") {
                if (i + 1 >= argc) {
                    std::cerr << "Error: -c requires a value\n";
                    return std::nullopt;
                }
                char* endptr = nullptr;
                unsigned long parsed = std::strtoul(argv[++i], &endptr, 10);
                if (*endptr != '\0') {
                    std::cerr << "Error: invalid count value\n";
                    return std::nullopt;
                }
                args.count = static_cast<std::size_t>(parsed);
                if (args.count < 1) {
                    std::cerr << "Error: -c must be >= 1\n";
                    return std::nullopt;
                }
            } else if (arg == "-nl") {
                args.lower = false;
            } else if (arg == "-nu") {
                args.upper = false;
            } else if (arg == "-nd") {
                args.digits = false;
            } else if (arg == "-ns") {
                args.symbols = false;
            } else if (arg == "-h" || arg == "--help") {
                printUsage();
                std::exit(0);
            } else {
                std::cerr << "Error: unknown flag '" << arg << "'\n";
                return std::nullopt;
            }
        }
    }
    return args;
}
