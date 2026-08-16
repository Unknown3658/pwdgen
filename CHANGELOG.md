# Changelog

All notable changes to this project will be documented in this file.

## [1.0.2] - 2025-08-16

### 🛠️ Security Fixes

- **Fixed**: `main.cpp` - Удалена вредная очистка структуры CliArgs с указателями (`std::memset(&args, 0, sizeof(args))`), которая могла приводить к использованию освобождённой памяти
- **Fixed**: `csprng_win.cpp` - Исправлен бесконечный цикл при ошибке `BCryptGenRandom` (ранее очищал буфер, но сбрасывал указатели на начальное состояние)
- **Fixed**: `password.cpp` - Исправлен алгоритм выборки символов: заменена 32-битная константа `0xFFFFFFFFUL` на 64-битную `0x100000000ULL` для обеспечения равномерного распределения при больших размерах алфавита

### 📝 Documentation

- **Added**: Comprehensive usage examples for various scenarios (password manager, email, database, API keys, SSH keys, etc.)
- **Added**: Security considerations section with entropy information (196 bits for 32-char passwords, 392 bits for 64-char)
- **Added**: Security testing guide for verifying entropy distribution
- **Updated**: README.md with new sections on usage, security, and testing
- **Updated**: README.ru.md with translated examples

### Removed
- Флаг `-ex` / `--exclude` — удалён функционал удаления символов из алфавита

## [1.0.1] - 2025-08-16

### Fixed
- Infinite loop при алфавите ≤1 символа — исправлено в #1
- Memory leak в Windows CSPRNG — исправлено в #2
- Зависание unit-тестов — исправлено в #3
- Добавлена валидация `--length <= 256` — исправлено в #4

### Added
- macOS support (опционально)
- Короткие флаги: `-l`, `-c`, `-nl`, `-nu`, `-nd`, `-ns`
- Русский help в `--help`
- Примеры использования в README

## [1.0.0] - 2025-08-15

### Added
- CSPRNG-based password generator
- Windows, Linux support
- Rejection sampling for unbiased index selection
- Full character set control with `-nl`, `-nu`, `-nd`, `-ns`
- MIT License
