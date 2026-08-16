#include "csprng.h"
#include "charset.h"
#include "password.h"
#include "cli.h"
#include <iostream>
#include <memory>
#include <cstring>

int main(int argc, char* argv[]) {
    auto args = parseArgs(argc, argv);
    if (!args) {
        return 1;
    }

    auto rng = makeCSPRng();
    Charset charset(args->lower, args->upper, args->digits, args->symbols);
    if (charset.size() == 0) {
        std::cerr << "Error: alphabet is empty\n";
        return 1;
    }

    for (std::size_t i = 0; i < args->count; ++i) {
        try {
            auto password = generate(*rng, charset, args->length);
            std::cout << password << "\n";
            // Clear the buffer after output to prevent memory disclosure
            std::memset(password.data(), 0, password.size());
        } catch (const std::exception& e) {
            std::cerr << "Error: " << e.what() << "\n";
            return 1;
        }
    }

    return 0;
}
