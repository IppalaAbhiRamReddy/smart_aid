# Smart Aid

Smart Aid is a comprehensive safety and emergency assistance application designed to provide quick access to first aid guides, emergency contacts, and critical tools like SOS signaling.

## Features

- **Emergency SOS:** Instantly activate visual SOS signals and share your live location with emergency contacts.
- **First Aid Guides:** Searchable, step-by-step first aid instructions for various medical scenarios, complete with text-to-speech support.
- **Medical ID:** Store and access critical medical information (allergies, conditions, blood group) and emergency contacts.
- **Reminders:** Set and manage medication and safety check reminders.
- **Quick Actions:** Direct dialing for Police, Ambulance, and Fire services.

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Backend:** [Firebase](https://firebase.google.com/) (Authentication, Cloud Firestore)
- **State Management:** Provider
- **Navigation:** GoRouter
- **Key Packages:**
  - `torch_light` (Flashlight control)
  - `flutter_tts` (Text-to-speech)
  - `flutter_local_notifications` (Reminders)
  - `url_launcher` (Calls & SMS)

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- Android Studio or VS Code with Flutter extensions.
- An Android Emulator or physical device.

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/IppalaAbhiRamReddy/smart_aid.git
    cd smart_aid
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```

## Project Structure

```
lib/
├── data/           # Data providers and static data
├── models/         # Data models (User, FirstAid, etc.)
├── screens/        # UI Screens
│   ├── auth/       # Login & Signup
│   ├── emergency/  # SOS & Emergency Actions
│   ├── first_aid/  # First Aid Guides
│   ├── home/       # Dashboard
│   ├── profile/    # User Profile & Settings
│   ├── reminders/  # Reminder Management
│   └── splash/     # App entry point
├── services/       # Business logic (Auth, Safety, etc.)
├── theme/          # App design system & styles
├── widgets/        # Reusable UI components
├── main.dart       # App entry point
└── router.dart     # Navigation configuration
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.
