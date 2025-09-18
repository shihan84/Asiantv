# Contributing to Asian TV Flutter Application

Thank you for your interest in contributing to the Asian TV Flutter application! This document provides guidelines and information for contributors.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contribution Guidelines](#contribution-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)
- [Contact Information](#contact-information)

## 🤝 Code of Conduct

This project is owned by **Asian TV Cable Network** and follows professional development standards. By participating, you agree to:

- Be respectful and professional in all interactions
- Follow the established coding standards and conventions
- Respect intellectual property and confidentiality
- Maintain the quality and integrity of the codebase
- Follow all applicable laws and regulations

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- Android Studio or VS Code
- Git
- Android device or emulator (API 21+)

### Development Setup

1. **Fork the repository**
   ```bash
   # Fork the repository on GitHub
   # Then clone your fork
   git clone https://github.com/YOUR_USERNAME/Asiantv.git
   cd Asiantv
   ```

2. **Set up the development environment**
   ```bash
   # Install dependencies
   flutter pub get
   
   # Run the application
   flutter run
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 📝 Contribution Guidelines

### Code Standards

- **Dart/Flutter:** Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- **Naming:** Use descriptive names for variables, functions, and classes
- **Comments:** Add meaningful comments for complex logic
- **Documentation:** Update documentation for new features
- **Testing:** Add tests for new functionality when applicable

### File Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # Screen widgets
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── live_tv_screen.dart
│   └── social_screens.dart
├── widgets/                  # Reusable widgets
├── utils/                    # Utility functions
└── constants/                # App constants
```

### Commit Guidelines

Use clear and descriptive commit messages:

```bash
# Good examples
git commit -m "feat: add video player controls"
git commit -m "fix: resolve orientation issue in live TV"
git commit -m "docs: update README with new features"

# Bad examples
git commit -m "fix"
git commit -m "update"
git commit -m "changes"
```

### Commit Types

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

## 🔄 Pull Request Process

1. **Create a Pull Request**
   - Ensure your branch is up to date with the main branch
   - Provide a clear description of your changes
   - Reference any related issues

2. **Pull Request Template**
   ```markdown
   ## Description
   Brief description of changes

   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation update

   ## Testing
   - [ ] Tested on Android device
   - [ ] Tested on emulator
   - [ ] All existing tests pass

   ## Screenshots (if applicable)
   Add screenshots to help explain your changes

   ## Checklist
   - [ ] Code follows style guidelines
   - [ ] Self-review completed
   - [ ] Documentation updated
   - [ ] No breaking changes
   ```

3. **Review Process**
   - All pull requests require review
   - Address feedback promptly
   - Make requested changes
   - Ensure all checks pass

## 🐛 Issue Reporting

### Before Creating an Issue

1. Check if the issue already exists
2. Ensure you're using the latest version
3. Try to reproduce the issue
4. Gather relevant information

### Issue Template

```markdown
## Bug Report

**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Device Information**
- Device: [e.g., Samsung Galaxy S21]
- OS: [e.g., Android 12]
- App Version: [e.g., 1.0.0]

**Additional context**
Add any other context about the problem here.
```

## 🏗️ Development Guidelines

### Adding New Features

1. **Plan the feature**
   - Define requirements
   - Consider user experience
   - Plan the implementation

2. **Implement the feature**
   - Follow coding standards
   - Add proper error handling
   - Include user feedback (loading states, etc.)

3. **Test thoroughly**
   - Test on different devices
   - Test edge cases
   - Verify performance

4. **Update documentation**
   - Update README if needed
   - Add code comments
   - Update changelog

### Modifying Existing Features

1. **Understand the current implementation**
   - Read existing code
   - Understand the purpose
   - Identify dependencies

2. **Make changes carefully**
   - Preserve existing functionality
   - Add new features without breaking old ones
   - Test thoroughly

3. **Update documentation**
   - Update relevant documentation
   - Add migration notes if needed

## 🔒 Security Considerations

- **Never commit sensitive information** (API keys, passwords, etc.)
- **Use environment variables** for configuration
- **Follow security best practices** for data handling
- **Report security vulnerabilities** privately to the development team

## 📞 Contact Information

For questions about contributing or the development process:

- **Email:** dev@asiantvnetwork.com
- **GitHub Issues:** [Create an issue](https://github.com/shihan84/Asiantv/issues)
- **Website:** [www.asiantvnetwork.com](https://www.asiantvnetwork.com)

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the same proprietary license as the project. See [LICENSE](../LICENSE) for details.

---

**Asian TV Cable Network**  
Hyderabad, India  
© 2024 All Rights Reserved
