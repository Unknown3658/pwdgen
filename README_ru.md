# pwdgen - Генератор паролей с CSPRNG для нескольких платформ
Генератор паролей без внешних зависимостей.

## Дисклеймер.
Я не разработчик и никогда им не был. 
Как бывший SAST инженер, и человек из сферы информационной безопасности я писал программу с фокусом на безопасность. 
Программа разработана с помощью локальной llm, Qwen3.5-9B-DeepSeek-V4-Flash-Q6_K, на стеке llama.cpp + OpenCode.
Программа прошла все правила по вектору безопасности SonarQube для С++.


### Принципы разработки проекта
- **Конфиденциальность**: Никакого логгирования, никакой истории, никаких баз данных. Пароль генерируется и исчезает.
- **Целостность**: Криптографически стойкий рандом. Никаких псевдослучайных генераторов.
- **Доступность**: Один запуск - один пароль.

## Возможности
- **Только CSPRNG** - нет `std::rand`, `mt19937` или генераторов с seed
- **Источники энтропии для каждой платформы:**
  - Windows: `BCryptGenRandom`
  - macOS: `SecRandomCopyBytes`
  - Linux: `getrandom()` (API ядра 3.17+) или `/dev/urandom` (fallback)
- **Полный контроль набора символов** с `-nl`, `-nu`, `-nd`, `-ns`

## Проверенные платформы
Работает и собирается гарантированно на windows, код для macOS и linux добавлен но сборки и работосособность не проверены.
Крч хз, тестируйте потом в issues расскажете. 

### Linux

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
cmake --test
```

### Windows (MSBuild)

```bash
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release
cmake --test --build . --config Release
```

### macOS

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build .
c_test
```

## Тестирование

```bash
cd build
cmake --test
# или с выводом:
cmake --test --output-on-failure
```

## Требования 

Языковая среда
- C++17
- MSVC 19.27+ (Visual Studio 2019)
- Или GCC 7+ / Clang 6+ (Linux/macOS) (по словам AI)

Среда разработки
- Visual Studio 2019/2022 (Windows)
- CMake 3.15+ (кроссплатформенная поддержка)


## Использование

| Флаг | Описание | По умолчанию |
|------|----------|--------------|
| `-h,   --help` | Справка | - |
| `-l N`| Длина пароля (16 ≤ N ≤ 256) | 16 |
| `-c M`| Количество паролей (M ≥ 1) | 1 |
| `-nl` | Исключить строчные буквы | включено |
| `-nu` | Исключить заглавные буквы | включено |
| `-nd` | Исключить цифры | включено |
| `-ns` | Исключить символы | включено |

### Быстрый старт

```
pwdgen           # 16-значный пароль со всеми типами символов
pwdgen -h        # Показать справку
```

```
# Только буквы и символы (без цифр)
pwdgen -l 24 -nd

# Только заглавные буквы и символы
pwdgen -l 20 -nl -nd -ns

# Только строчные буквы (без других типов)
pwdgen -l 32 -nu -nd -ns

# Все типы, кроме символов (буквы + цифры)
pwdgen -l 24 -ns
```

## Лицензия

MIT License - см. [LICENSE](LICENSE)


## Архитектура
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
