#include "password.h"
#include "charset.h"
#include "csprng.h"
#include <cstdint>
#include <stdexcept>

std::string generate(CSPRng& rng, const Charset& charset, std::size_t length) {
    if (length > 256) {
        throw std::length_error("password length must be <= 256");
    }
    if (length == 0) {
        throw std::invalid_argument("password length must be >= 1");
    }
    std::string result;
    result.reserve(length);
    std::size_t alphabet_size = charset.size();
    if (alphabet_size == 0) {
        throw std::invalid_argument("alphabet is empty");
    }

	for (std::size_t i = 0; i < length; ++i) {
		uint64_t max_val = 0x100000000ULL * (alphabet_size / 0x100000000ULL + 1);
		while (true) {
            uint32_t val = rng.nextUint32();
            if (val < max_val) {
                std::size_t idx = static_cast<std::size_t>(val % alphabet_size);
                result.push_back(charset[idx]);
                break;
            }
        }
    }
    return result;
}
