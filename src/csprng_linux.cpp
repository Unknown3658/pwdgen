#include "csprng.h"
#include <cstdio>
#include <cstring>
#include <sys/random.h>
#include <sys/stat.h>
#include <unistd.h>

class LinuxCSPRng : public CSPRng {
private:
    bool hasGetrandom() {
        uint8_t buf[1];
        return getrandom(buf, 1, 0) > 0;
    }

public:
    void fill(void* buf, size_t n) override {
        uint8_t* dst = static_cast<uint8_t*>(buf);
        size_t remaining = n;

        if (hasGetrandom()) {
            while (remaining > 0) {
                size_t chunk = remaining < 1024 ? remaining : 1024;
                ssize_t got = ::getrandom(dst, chunk, 0);
                if (got > 0) {
                    dst += got;
                    remaining -= got;
                } else if (got == -1 && errno == EINTR) {
                    continue;
                } else if (got == -1) {
                    break;
                } else {
                    // Partial write on error - clear and break
                    memset(dst, 0, chunk);
                    break;
                }
            }
        }

        // Fallback to /dev/urandom if partial data remains
        if (remaining > 0) {
            FILE* f = fopen("/dev/urandom", "rb");
            if (!f) {
                memset(dst, 0, n);
                return;
            }
            while (remaining > 0) {
                size_t chunk = remaining < 1024 ? remaining : 1024;
                ssize_t got = fread(dst, 1, chunk, f);
                if (got > 0) {
                    dst += got;
                    remaining -= got;
                } else {
                    memset(dst, 0, chunk);
                    break;
                }
            }
            fclose(f);
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
    return std::make_unique<LinuxCSPRng>();
}
