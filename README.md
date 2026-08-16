# pwdgen - Multi-platform CSPRNG Password Generator
Password generator with no external dependencies.

## Disclaimer
I am not a developer, nor have I ever been one.
As a former SAST engineer and an information security professional, I wrote the program with a focus on security.
The program was developed using a local LLM Qwen3.5-9B-DeepSeek-V4-Flash-Q6_K on a llama.cpp + OpenCode stack.
The program passed all SonarQube security checks for C++.


## Development Principles
- **Confidentiality**: No logging, no history. A password is generated and disappears.
- **Integrity**: Cryptographically secure randomness only. No pseudo-random generators.
- **Availability**: One run - one password.

## Features
- **CSPRNG only** - no `std::rand`, `mt19937`, or seed-based generators
- **Platform-specific entropy sources:**
  - Windows: `BCryptGenRandom`
  - macOS: `SecRandomCopyBytes`
  - Linux: `getrandom()` (kernel API 3.17+) or `/dev/urandom` (fallback)
- **Full character set control** with `-nl`, `-nu`, `-nd`, `-ns`

### Verified platforms
It works and builds reliably on Windows; code for macOS and Linux has been added, but builds and functionality haven't been verified.
Anyway, who knows-test it out and let me know in the issues.

### Linux

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
ctest
```

### Windows (MSBuild)

```bash
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
ctest --build . --config Release
```

### macOS

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
c_test
```


## Testing

```bash
cd build
ctest
# or with output:
ctest --output-on-failure
```


## Requirements

Language Environment
- C++17
- MSVC 19.27+ (Visual Studio 2019)
- Or GCC 7+ / Clang 6+ (Linux/macOS) (according to AI)

Development Environment
- Visual Studio 2019/2022 (Windows)
- CMake 3.15+ (cross-platform support)


### Common Scenarios

| Flag | Description | Default |
|------|-------------|---------|
| `-h, --help` | Show this help message | - |
| `-l N`| Password length (16 ≤ N ≤ 256) | 16 |
| `-c M`| Number of passwords (M ≥ 1) | 1 |
| `-nl` | Exclude lowercase letters | enabled |
| `-nu` | Exclude uppercase letters | enabled |
| `-nd` | Exclude digits | enabled |
| `-ns` | Exclude symbols | enabled |


### Quick Start

```
pwdgen # 16-character password with all character types
pwdgen -h # Show help
```

```
# Only letters and symbols (no numbers)
pwdgen -l 24 -nd

# Only uppercase letters and symbols
pwdgen -l 20 -nl -nd -ns

# Only lowercase letters (no other types)
pwdgen -l 32 -nu -nd -ns

# All types except symbols (letters + numbers)
pwdgen -l 24 -ns
```


## License

MIT License - see [LICENSE](LICENSE)


## Architecture
```
src/
├── main.cpp           # точка входа
├── cli.cpp            # разбора аргументов командной строки
├── charset.cpp        # управление набором символов
├── password.cpp       # генерация паролей (rejection sampling)
├── csprng_win.cpp     # Windows CSPRNG (BCryptGenRandom)
├── csprng_linux.cpp   # Linux CSPRNG (getrandom + /dev/urandom)
├── csprng_mac.cpp     # macOS CSPRNG (SecRandomCopyBytes)
├── csprng.h           # интерфейс CSPRNG
├── charset.h          # интерфейс Charset
├── password.h         # интерфейс Password
└── cli.h              # интерфейс CLI

┌──────────┐     ┌──────────────┐     ┌────────┐
│ main()   │────>│parseArgs()   │────>│CliArgs │
└──────────┘     └──────────────┘     └────┬───┘
                                          │
                                          ▼
                                   ┌─────────────┐
                                   │ charset.cpp │
                                   │  Charset    │
                                   └──────┬──────┘
                                          │
                                          ▼
                                   ┌─────────────┐
                                   │password.cpp │
                                   │ generate()  │
                                   │rejection    │
                                   └──────┬──────┘
                                          │
                                          ▼
                                   ┌─────────────┐
                                   │ csprng.h    │
                                   └──────┬──────┘
                                          │
           ┌──────────────────────────────┼────────────────────────┐
           ▼                              ▼                        ▼
   ┌───────────────┐             ┌───────────────┐           ┌──────────────┐
   │ Windows       │             │ Linux         │           │ macOS        │
   │BCryptGenRandom│             │getrandom +    │           │SecRandomCopy │
   │               │             │/dev/urandom   │           │Bytes         │
   └───────┬───────┘             └───────┬───────┘           └───────┬──────┘
           │                             │                           │ 
           └─────────────────────────────┼───────────────────────────┘
                        	             │
                                         ▼
                    		     ┌─────────────┐
                    		     │ uint32_t    │
                    		     └──────┬──────┘
                           	            │
                           	            ▼
                    		     ┌─────────────┐
                    		     │   stdout    │
                    		     └─────────────┘
```
