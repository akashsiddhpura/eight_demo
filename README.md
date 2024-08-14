# 🎧 Flutter Audio Player App for iOS and Android

## Introduction

This project is an iOS audio player app built using Flutter. The app demonstrates the use of Clean Architecture, MVVM, and state management with BLoC. It supports playback of m3u8 HLS (HTTP Live Streaming) audio streams and includes various features like background playback and custom notification controls.

## Features

### 1. Playing m3u8 HLS Audio
- Supports playback of m3u8 HLS audio streams with seamless streaming.

### 2. Player Controls
- **Play/Pause**: Basic play and pause functionality to control audio playback.
- **Rewind/Fast Forward**: Allows rewinding and forwarding the audio by 10 seconds.

### 3. Background Media Playback
- Continues playing audio even when the app is minimized or the screen is off.
- Utilizes Flutter isolates for efficient background task management.

### 4. Custom Notification Buttons
- Custom notification controls with buttons for Play/Pause, Rewind, and Fast Forward while the app is playing audio in the background.


## Architectural Pattern

### Clean Architecture / MVVM
- The app is built using the principles of Clean Architecture, ensuring separation of concerns and maintainability.
- Implements the MVVM design pattern with BLoC for effective state management.

## State Management

### BLoC (Business Logic Component)
- The app uses BLoC to manage the state across the app. 
- Ensures a clear separation of business logic from the UI, improving testability and consistency.

## Project Structure

```
lib/
|-- data/                       # Data layer: Repositories, data sources, etc.
|-- domain/                     # Domain layer: Entities, use cases, interfaces.
|-- presentation/               # Presentation layer: BLoC, UI widgets.
|-- main.dart                   # Entry point of the application.
```

## Getting Started

### Prerequisites

- Flutter SDK
- Xcode (for iOS development)
- An Apple Developer account (for background playback and notification controls)

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/flutter-audio-player-ios.git
    cd flutter-audio-player-ios
    ```

2. Install dependencies:
    ```bash
    flutter pub get
    ```

3. Run the app on an iOS simulator or device:
    ```bash
    flutter run
    ```

### Note:
- For background playback, ensure that your project is properly configured in Xcode, with the necessary permissions and capabilities enabled.
- The app requires a valid Apple Developer account to run on physical iOS devices due to background playback and notification features.

## Usage

- Launch the app, and select a m3u8 HLS audio stream to start playback.
- Use the on-screen controls to play, pause, rewind, or fast-forward the audio.
- Minimize the app or turn off the screen to test background playback.
- Observe custom notification controls while audio is playing in the background.

## Demo Video

A short video demonstrating the app's features.

https://github.com/user-attachments/assets/26c4f898-1e12-468d-b1c8-9d122b6fe1c5


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries or feedback, please contact [aksiddhpura410@gmail.com](mailto:aksiddhpura410@gmail.com).
