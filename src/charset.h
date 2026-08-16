#ifndef CHARSET_H
#define CHARSET_H

#include <cstddef>
#include <string>
#include <string_view>

class Charset {
public:
    Charset(bool lower, bool upper, bool digits, bool symbols);
    [[nodiscard]] std::size_t size() const;
    [[nodiscard]] char operator[](std::size_t i) const;

private:
    std::string m_alpha;
};

#endif // CHARSET_H
