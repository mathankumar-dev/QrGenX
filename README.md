<div align="center">

<img src="assets/images/qrgenx_logo.png" alt="QrGenX logo" width="120"/>

# QrGenX

**Scan. Generate. Manage.**
A clean, fast, and minimal Flutter app for everything QR codes.

![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.7%2B-0175C2?logo=dart)
![Status](https://img.shields.io/badge/status-active-success)

</div>

---

## About

QrGenX is a Flutter mobile app that lets you scan QR codes and barcodes using your camera or a gallery image, generate custom QR codes from text or URLs, and keep a local history of everything you scan. It ships with a soft, neumorphic-inspired UI and full light/dark theme support.

## Features

- **Camera scanning** — point your camera at a QR code or barcode for instant detection, powered by `mobile_scanner`.
- **Scan from gallery** — pick an image, crop it to the code, and decode it with `zxing2`.
- **Smart result handling** — detected URLs get an "Open Link" button; everything else is shown as selectable text.
- **QR generation** — turn any text or URL into a QR code, rendered with `qr_flutter`.
- **Share generated codes** — export the generated QR as a PNG and share it via `share_plus`.
- **Scan history** — every scan (camera or gallery) is saved locally with Hive, showing the value, type, and timestamp. Delete individual entries or clear everything at once.
- **Light & dark themes** — toggle instantly from Settings, powered by `provider` and an animated theme transition.
- **Splash & welcome screen** — branded native splash (`flutter_native_splash`) followed by an animated welcome screen.
- **Settings** — theme toggle, privacy policy link, share-the-app, and app version info.

## Tech Stack

| Layer | Tools |
|---|---|
| Framework | Flutter (Dart SDK ^3.7.2) |
| State management | `provider` |
| Local storage | `hive`, `hive_flutter` |
| QR/barcode scanning | `mobile_scanner`, `zxing2`, `image_picker`, `image_cropper` |
| QR generation | `qr_flutter` |
| Sharing & links | `share_plus`, `url_launcher` |
| Fonts & branding | `google_fonts`, `flutter_launcher_icons`, `flutter_native_splash` |
| Utilities | `permission_handler`, `path_provider`, `package_info_plus`, `intl` |

## Project Structure

```
lib/
├── main.dart                       # App entry point, Hive + Provider setup
├── common/
│   ├── app_colors.dart             # Shared color palette
│   ├── pages/
│   │   ├── main_template_screen.dart   # Bottom-nav shell (Scan/Create/History/Settings)
│   │   ├── splash_screen.dart
│   │   └── welcome_page.dart
│   ├── provider/
│   │   ├── history_provider.dart
│   │   ├── navigation_provider.dart
│   │   └── theme_provider.dart
│   ├── theme/Theme.dart            # Light/dark theme definitions
│   ├── utils/qr_decoder.dart       # zxing2-based image decoding
│   └── widgets/                    # Shared buttons & containers
├── data/
│   └── models/scanned_code_model.dart  # Hive model for scan history
└── features/
    ├── scan/                       # Camera & gallery scanning
    ├── generate/                   # QR generation page
    ├── history/                    # Scan history list
    └── setting/                    # App settings
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (compatible with Dart ^3.7.2)
- Android Studio / Xcode for platform builds
- A physical device or emulator with a working camera (for scanning)

### Installation

```bash
# Clone the repository
git clone https://github.com/mathankumar-dev/QrGenX.git
cd QrGenX

# Install dependencies
flutter pub get

# Generate Hive adapters (if you change the data model)
flutter pub run build_runner build

# Run the app
flutter run
```

### Build a release

```bash
flutter build apk --release      # Android
flutter build ios --release      # iOS
```

## Permissions

QrGenX requests the following permissions to power its scanning features:

- **Camera** — for live QR/barcode scanning
- **Photos / Media images** — to pick and decode QR codes from your gallery

## Privacy Policy

Read the app's privacy policy [here](https://sites.google.com/view/mkapps-qrgenx).

## Contributing

Contributions are welcome. Fork the repo, create a feature branch, and open a pull request with a clear description of your changes.

## Author

Built by [Mathan Kumar](https://github.com/mathankumar-dev).
