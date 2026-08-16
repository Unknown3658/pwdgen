#ifndef CSPRNG_H
#define CSPRNG_H

#include <cstddef>
#include <cstdint>
#include <memory>

class CSPRng {
public:
    virtual ~CSPRng() noexcept = default;
    virtual void fill(void* buf, size_t n) = 0;
    virtual uint32_t nextUint32() = 0;
};

/// Allocate a CSPRng implementation. Caller owns the returned unique_ptr.
[[nodiscard]] std::unique_ptr<CSPRng> makeCSPRng();

#endif // CSPRNG_H
