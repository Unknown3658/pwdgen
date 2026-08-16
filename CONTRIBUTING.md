# Contributing

Thank you for your interest in contributing to pwdgen! Before submitting a pull request, please read these guidelines.

## How to Contribute

1. **Fork the repository**
2. **Create a feature branch**:
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes**
4. **Commit your changes**:
   ```bash
   git commit -m 'Add amazing feature'
   ```
5. **Push to the branch**:
   ```bash
   git push origin feature/amazing-feature
   ```
6. **Open a Pull Request**

## Code Style

- Follow existing code style (see `cli.cpp`, `main.cpp`, `csprng_win.cpp`)
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused
- Use `[[nodiscard]]` for functions that should not be ignored

## Testing

- Run all tests before submitting a PR
- Tests must pass on Windows, Linux, and macOS
- New features should include tests
- Edge cases must be handled

## Pull Request Guidelines

- **Title**: Clear and concise description of the change
- **Description**: Explain what you changed and why
- **Screenshots**: For UI changes, include before/after
- **Build**: Ensure the project builds without errors
- **Tests**: All tests must pass

## Issue Tracker

- Use the [GitHub Issues](https://github.com/yourusername/password_generator_C++/issues) to report bugs or request features
- Provide as much detail as possible
- Include steps to reproduce bugs

## License

By contributing to this project, you agree to license your contributions under the MIT License.
