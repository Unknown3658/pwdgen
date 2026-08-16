#ifndef PASSWORD_H
#define PASSWORD_H

#include <cstddef>
#include <cstdint>
#include <string>

class CSPRng;
class Charset;

[[nodiscard]] std::string generate(CSPRng& rng, const Charset& charset, std::size_t length);

#endif // PASSWORD_H
