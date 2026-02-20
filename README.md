# Chatna


Chatna is a real-time messaging application built with Flutter and backed by Firebase. It provides a seamless chatting experience with features like user authentication, live message updates, and a clean, user-friendly interface.

## Features

- **Real-time Messaging**: Leverages Cloud Firestore streams to deliver messages instantly.
- **User Authentication**: Secure user registration and login with Firebase Authentication.
  - Email & Password sign-up with email verification.
  - Google Sign-In for quick access.
- **Password Recovery**: "Forgot Password" functionality for email-based accounts.
- **Dynamic Chat Interface**: Displays messages in styled chat bubbles, differentiating between the current user and other participants.
- **User Profiles**: Displays the sender's name above their messages.
- **Responsive UI**: Adapts to different screen sizes using `flutter_screenutil`.

## Tech Stack & Architecture

- **Framework**: Flutter
- **Backend-as-a-Service**: Firebase
  - **Authentication**: Manages user sign-up, sign-in, and session persistence.
  - **Cloud Firestore**: A NoSQL database for storing and retrieving chat messages in real-time.
- **Key Packages**:
  - `firebase_core`, `firebase_auth`, `cloud_firestore` for Firebase integration.
  - `google_sign_in` for Google authentication.
  - `chat_bubbles` for styling the chat message UI.
  - `flutter_screenutil` for creating a responsive UI.
  - `awesome_dialog` for displaying informative dialogs.

The project follows a feature-driven directory structure to maintain organized and scalable code:

- `lib/core`: Contains shared utilities, including Firebase services, helper functions, and theme constants.
- `lib/features`: Houses the main application features, separated into `auth` (for sign-in/sign-up) and `chat` (for the main chat interface).
- `lib/models`: Defines the data structures, such as the `MessageModel`.
- `lib/main.dart`: The entry point for the application, handling initialization and routing.

## Getting Started

To get a local copy up and running, follow these steps.

### Prerequisites

- Flutter SDK installed.
- A configured IDE like VS Code or Android Studio.
- A Firebase account.

### Firebase Configuration

1.  Create a new project on the [Firebase Console](https://console.firebase.google.com/).
2.  Enable **Authentication** and add the **Email/Password** and **Google** sign-in providers.
3.  Set up **Cloud Firestore** and create a `users` collection. Configure security rules as needed.
4.  Register your application (Android, iOS, Web) in the Firebase project settings.
5.  Use the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) to configure your app. This will generate a `firebase_options.dart` file, which will replace the one in this repository.
    ```sh
    flutterfire configure
    ```
6.  For Android, place your own `google-services.json` file in `android/app/`.
7.  For iOS, place your `GoogleService-Info.plist` file in `ios/Runner/` via Xcode.

### Installation & Execution

1.  Clone the repository:
    ```sh
    git clone https://github.com/khaledbahjat/chat_app.git
    ```
2.  Navigate to the project directory:
    ```sh
    cd chat_app
    ```
3.  Install the dependencies:
    ```sh
    flutter pub get
    ```
4.  Run the application:
    ```sh
    flutter run
