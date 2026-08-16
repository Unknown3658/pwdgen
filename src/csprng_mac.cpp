#include "csprng.h"
#include <security/mac.h>

class MacCSPRng : public CSPRng {
public:
    void fill(void* buf, size_t n) override {
        SecRandomCopyBytes(kSecRandomDefault, static_cast<SizeT>(n), static_cast<UInt8*>(buf));
    }

    uint32_t nextUint32() override {
        uint8_t buf[4]{};
        fill(buf, 4);
        uint32_t val{};
        memcpy(&val, buf, sizeof(val));
        return val;
    }
};

static std::unique_ptr<CSPRng> s_rng;

std::unique_ptr<CSPRng> makeCSPRng() {
    return std::make_unique<MacCSPRng>();
}