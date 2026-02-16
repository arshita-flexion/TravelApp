# FlutterBaseProject

[![Flutter Version](https://img.shields.io/badge/Flutter-3.35.3-blue.svg)](https://flutter.dev/)
[![Dart SDK](https://img.shields.io/badge/Dart-3.9.2%2B-blue.svg)](https://dart.dev/)

## Overview
Flutter base app


## Project Structure (MVVM)
```
├── core/
│   ├── api_config/
│   ├── app/
│   ├── check_connection/
│   ├── flavor_config/
│   ├── generated/
│   ├── global/
│   ├── l10n/
│   ├── routes/
│   ├── themes/
│   └── utils/
├── main/
│   ├── main_dev.dart
│   ├── main_prod.dart
│   └── main_stage.dart
├── models/
├── repository/
├── viewmodels/
├── views/
└── widgets/
```

## Getting Started

### Prerequisites
- Flutter SDK 3.38.2
- Dart SDK 3.10.0
- Android Studio / VS Code
- Git

## Dependencies

### Core Dependencies

- **flutter_localizations**: Flutter's internationalization and localization support for multiple languages
- **flutter_bloc**: ^9.1.0 - State management solution implementing the BLoC pattern
- **dio**: ^5.8.0+1 - HTTP client for making API requests with interceptors, global configuration, and more
- **cupertino_icons**: ^1.0.8 - Collection of iOS-style icons for Flutter applications
- **path_provider**: ^2.1.5 - Plugin for finding commonly used locations on the filesystem
- **connectivity_plus**: ^6.1.3 - Plugin for discovering network connectivity state
- **animated_splash_screen**: ^1.3.0 - Customizable animated splash screen for app launch
- **flutter_screenutil**: ^5.9.3 - Responsive UI solution for adapting to different screen sizes

### UI Components

- **lottie**: ^3.3.2 - Parse and render Adobe After Effects animations exported as JSON
- **flutter_svg**: ^2.1.1 - SVG rendering library
- **cached_network_image**: ^3.4.1 - Widget for loading and caching network images with placeholder and error handling
- **flutter_cache_manager**: ^3.4.1 - Generic cache manager for Flutter with cache control
- **shimmer**: ^3.0.0 - Package providing shimmer effect for loading content placeholders
- **validators**: ^3.0.0 - String validation utilities for forms
- **equatable**: ^2.0.7 - Abstract class for value equality without boilerplate
- **flutter_native_splash**: ^2.4.5 - Native splash screen generator
- **flutter_dotenv**: ^6.0.0 - Load environment variables from .env files
- **device_info_plus**: ^12.0.0 - Plugin for accessing device information

### Code Generation

- **auto_gen_assets**: Asset code generator package
- **intl**: Localization and string generation (with `flutter: generate: true`)


## Commands for Code Generation

```bash
# Generate assets (one-time)
dart run auto_gen_assets

# Watch mode (auto-regenerate on changes)
dart run auto_gen_assets --watch
```

## Strings are generated via Flutter localization when `flutter: generate: true` is enabled.

```yaml
# pubspec.yaml (relevant parts)
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2

flutter:
  generate: true
```

```yaml
# l10n.yaml (project root)
arb-dir: lib/core/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

## Environment Configuration
The app supports three environments:

### Running the App

**Development:**
```bash
flutter run --flavor dev -t lib/main/main_dev.dart
```

**Staging:**
```bash
flutter run --flavor stage -t lib/main/main_stage.dart
```

**Production:**
```bash
flutter run --flavor prod -t lib/main/main_prod.dart
```

### Building the App

**Development APK:**
```bash
flutter build apk --flavor dev -t lib/main/main_dev.dart
```

**Staging APK:**
```bash
flutter build apk --flavor stage -t lib/main/main_stage.dart
```

**Production APK:**
```bash
flutter build apk --flavor prod -t lib/main/main_prod.dart
```


