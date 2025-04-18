# Shopping Mall App

A Flutter e-commerce application demonstrating Firebase authentication, product browsing, and sharing functionality.

## Features

- Firebase Authentication (Email & Password)
- Product list loaded from `products.json`
- Bloc/Cubit state management
- Share product details via Share Plus plugin
- Responsive design for Android, iOS, web, and desktop

## Prerequisites

- Flutter 3.10.5 (stable)
- Dart 2.18.1
- Android SDK 35
- Xcode 14 (for iOS)
- Android Studio 2022.2 or VS Code with Flutter plugin installed

## Dependencies

| Package         | Version  |
|-----------------|----------|
| flutter_bloc    | ^9.1.0   |
| bloc            | ^9.0.0   |
| firebase_core   | ^3.13.0  |
| firebase_auth   | ^5.5.2   |
| share_plus      | ^7.2.1   |
| provider        | ^6.1.1   |
| intl            | ^0.17.0  |
| cupertino_icons | ^1.0.2   |

## Getting Started

1. Clone the repository:
   ```bash
   git clone <YOUR-REPO-URL>
   ```
2. Navigate into the project:
   ```bash
   cd shopping_mall
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

## Running the App


### Android
```bash
flutter run -d emulator-5554 
```
or use this command if it did not work

```bash
flutter run --no-enable-impeller
```

### iOS
```bash
flutter run -d ios
```

### Web
```bash
flutter run -d chrome
```

## Configuration

1. In `android/local.properties`, set:
   ```
   flutter.sdk=/path/to/flutter
   flutter.versionCode=1
   flutter.versionName=1.0
   ```
2. Place your Firebase `google-services.json` in `android/app/`.
3. Place your Firebase `GoogleService-Info.plist` in `ios/Runner/`.

## Directory Structure

```
lib/
  main.dart
  screens/
    shop/
      product_detail_page.dart
    profile/
      sign/
        sign_cubit.dart
  widgets/
    home_layout.dart
assets/
  products.json
android/
ios/
pubspec.yaml
```

## Troubleshooting

- **Kotlin version errors**: In `android/build.gradle` update:
  ```gradle
  ext.kotlin_version = '1.8.22'
  ```
- **minSdkVersion errors**: Ensure `minSdkVersion` is at least 23 in `android/app/build.gradle`.
- After changes, run:
  ```bash
  flutter clean
  flutter pub get
  ```

## Contributing

Contributions are welcome. Open issues or submit pull requests.
