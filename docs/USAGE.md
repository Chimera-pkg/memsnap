# MEMSNAP — Usage & Run Notes

Quick instructions to run the app and tests locally.

Prerequisites:
- Flutter SDK installed and available on PATH

Run the app:
```bash
flutter pub get
flutter run
```

Run tests:
```bash
flutter test
```

What was added:
- `GemController` (core controllers) — persistence via `SharedPreferences`.
- Provider integration in `main.dart`.
- Simple `HomeScreen` and `ShopScreen` demos in `lib/features`.
- Unit tests at `test/gem_controller_test.dart`.
- Placeholder audio folder: `assets/audio/` (register in `pubspec.yaml`).

Next steps:
- Add real audio assets into `assets/audio/` and update code to play via an audio package.
- Integrate `in_app_purchase` for real purchases.
