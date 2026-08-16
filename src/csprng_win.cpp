#include <windows.h>
#include "csprng.h"
#include <bcrypt.h>

class WindowsCSPRng : public CSPRng {
public:
    void fill(void* buf, size_t n) override {
        uint8_t* dst = static_cast<uint8_t*>(buf);
        size_t remaining = n;
        while (remaining > 0) {
            BYTE* p = static_cast<BYTE*>(dst);
            DWORD bytes = static_cast<DWORD>(remaining);
            DWORD ret = BCryptGenRandom(nullptr, p, bytes, BCRYPT_USE_SYSTEM_PREFERRED_RNG);
            if (ret != ERROR_SUCCESS) {
                // Clear any partially written data on error
                if (bytes > 0) {
                    memset(dst, 0, static_cast<size_t>(bytes));
                }
                // Return with empty buffer - caller will handle error
                return;
            }
            dst = static_cast<uint8_t*>(p);
            remaining -= bytes;
        }
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
    return std::make_unique<WindowsCSPRng>();
}
