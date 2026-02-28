# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**makhorij_app** — A Flutter game to learn Arabic letters. Early-stage MVP.

## Common Commands

```bash
flutter pub get          # Install dependencies
flutter run              # Run on connected device/emulator
flutter test             # Run all tests
flutter test test/widget_test.dart  # Run a single test file
flutter analyze          # Static analysis
flutter format lib/      # Format code
```

## Architecture

The app uses standard Flutter widget architecture with `StatefulWidget` + `setState()` for local state. No state management library has been added yet.

**Key structure:**
- `lib/main.dart` — App entry point and root widget (`MyApp`)
- `lib/ui/screens/` — Screen-level widgets; currently only `SingleWordScreen` (placeholder)

Screens live under `lib/ui/screens/`. As the app grows, organize new code under `lib/ui/` (widgets, screens) and add `lib/models/` and `lib/services/` as needed.

## Dependencies

- Flutter SDK, `cupertino_icons` — no third-party state management or navigation packages yet
- Dev: `flutter_lints` for linting (configured in `analysis_options.yaml`)