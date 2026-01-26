# Screen Implementation Details

This document provides a detailed overview of the implementation of each screen in the Smart Aid application, located in `lib/screens/main`.

## Authentication

### Login Screen

**File:** `lib/screens/main/auth/login_screen.dart`

**Purpose:** Allows users to sign in to the application using email and password.

**Key Components:**

- **Input Fields:** Email and Password text fields.
- **State Management:** Uses `AuthService` (provider) for authentication logic.
- **Interaction:**
  - `_login()`: Validates input and calls `authService.signInWithEmail`. On success, navigates to `/home`.
  - `_showForgotPasswordDialog()`: Opens a dialog to enter email for password reset.
  - Navigate to Signup: `context.go('/signup')`.

**Implementation Details:**

- Uses `TextEditingController` for inputs.
- Handles loading state with `_isLoading`.
- Displays `SnackBar` for errors/success.

### Signup Screen

**File:** `lib/screens/main/auth/signup_screen.dart`

**Purpose:** Allows new users to create an account.

**Key Components:**

- **Input Fields:** Name, Age, Email, Password, Confirm Password.
- **State Management:** Uses `AuthService` to create account and profile.
- **Interaction:**
  - `_signup()`: Validates all fields (including password match). Calls `authService.signUpWithEmail`.
  - Creates a `UserModel` and saves it via `createProfile`.
  - Sends email verification.

## Main Screens

### Home Screen

**File:** `lib/screens/main/home/home_screen.dart`

**Purpose:** The central dashboard of the application, providing quick access to safety features and status.

**Key Components:**

- **Status Widget:** Shows current status (SOS Active, Location Sharing, or Normal). Changes color dynamically (Red for SOS, Green for Sharing, Blue for Normal).
- **Quick Actions Grid:**
  - **First Aid:** Navigates to First Aid list.
  - **Flashlight/SOS:** Toggles flashlight or activates visual SOS mode (strobe).
  - **Emergency:** Navigates to Emergency screen.
  - **Medical ID:** Navigates to Profile.
- **Safety Tip Card:** Displays a random safety tip, rotatable daily.

**Implementation Details:**

- **Flashlight:** Uses `torch_light` package. `_toggleFlashlight` handles on/off.
- **SOS Mode:** `_startSosMode` starts a timer to flash the torch in SOS pattern (... --- ...).
- **Refactoring Note:** Styles (Colors/Fonts) are imported from `lib/screens/main/styling`.

### Emergency Screen

**File:** `lib/screens/main/emergency/emergency_screen.dart`

**Purpose:** Critical screen for immediate emergency actions.

**Key Components:**

- **SOS Button:** Large, pulsing button to activate SOS. Requesting user to "Double Tap" to activate avoiding accidental touches.
- **Status State:** When active, shows strictly "SOS Activated" and allows marking safe.
- **Emergency Services Grid:** Quick dial buttons for Police (100), Ambulance (108), etc.

**Implementation Details:**

- **SOS Action:** `_activateSOS` vibrates device, sets global SOS state via `SafetyService`, and attempts to send SMS with location to emergency contacts.
- **SMS Intent:** Uses `url_launcher` with `sms:` scheme.
- **Mark Safe:** `_markSafe` deactivates SOS and sends "I'm Safe" message.

### First Aid Screen

**File:** `lib/screens/main/first_aid/first_aid_screen.dart`

**Purpose:** Searchable list of first aid guides.

**Key Components:**

- **Search Bar:** Real-time filtering of items.
- **Category Chips:** Filter by tags (All, Common, Critical, Outdoor).
- **List View:** Displays `FirstAidItem` cards with severity indicators.

**Implementation Details:**

- Data source: `FirstAidData.items`.
- Filtering logic in `_filterItems` based on search text and category matches.
- Navigation: Tapping an item opens `FirstAidDetailScreen`.

### First Aid Detail Screen

**File:** `lib/screens/main/first_aid/first_aid_detail_screen.dart`

**Purpose:** Step-by-step instructions for a specific medical scenario.

**Key Components:**

- **Tabs:** "Steps", "Do & Don't", "Tools".
- **TTS (Text-to-Speech):** Button in AppBar to read instructions aloud using `flutter_tts` (via `TtsService`).
- **Steps Tab:** Numbered list of actions.
- **Do/Don't Tab:** Visual check/cross list for safety advice.

### Reminders Screen

**File:** `lib/screens/main/reminders/reminders_screen.dart`

**Purpose:** Manage medication and safety check reminders.

**Key Components:**

- **Time Slots:** Grouped by Morning, Afternoon, Evening.
- **Add/Edit Dialog:** Modal bottom sheet to set time, label, category, and repeat frequency.
- **Platform:** Uses `ReminderService` (local notifications logic).

**Implementation Details:**

- **Sorting:** Reminders are sorted by time within their sections.
- **State:** Uses `Consumer<ReminderService>` to listen to changes.

### Profile Screen

**File:** `lib/screens/main/profile/profile_screen.dart`

**Purpose:** User profile and medical ID settings.

**Key Components:**

- **Profile Card:** Shows photo, name, age, blood group. Supports image picking.
- **Medical Info:** Fields for Allergies, Conditions, Medications.
- **Emergency Contacts:** Add/Remove contacts for SOS features.
- **Preferences:** Language and Font Size settings (persisted via `PreferencesService`).

## Styling

**Directory:** `lib/screens/main/styling/`

- **theme.dart:** Defines the global `ThemeData`, including `CardTheme`, `InputDecorationTheme`, etc.
- **app_styles.dart:** Custom text styles and decoration constants (`AppTextStyles`).
- **constants.dart:** Application colors (`AppColors`) and global constants.

## Navigation

**Router:** implemented in `lib/router.dart` (implied) or `main.dart` using `GoRouter`.

- Routes: `/home`, `/login`, `/signup`, `/profile`, `/emergency`, `/first-aid`, `/reminders`.
