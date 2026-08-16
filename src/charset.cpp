#include "charset.h"

static const std::string LOWER   = "abcdefghijklmnopqrstuvwxyz";
static const std::string UPPER   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
static const std::string DIGITS  = "0123456789";
static const std::string SYMBOLS = "!@#$%^&*()_+-=[]{}|;':\",./<>?";

Charset::Charset(bool lower, bool upper, bool digits, bool symbols) {
    m_alpha.clear();
    if (lower)   m_alpha += LOWER;
    if (upper)   m_alpha += UPPER;
    if (digits)  m_alpha += DIGITS;
    if (symbols) m_alpha += SYMBOLS;
}

std::size_t Charset::size() const { return m_alpha.size(); }

char Charset::operator[](std::size_t i) const { return m_alpha[i]; }
