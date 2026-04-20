# MediLink 360

MediLink 360 is a comprehensive healthcare companion app built with Flutter. It bridges the gap between healthcare providers and patients by offering dual, role-based interfaces designed to streamline medical appointments, symptom checking, and patient management.

## Features

### 🧑‍⚕️ For Doctors
- **Dashboard:** A comprehensive overview of daily appointments and patient statistics.
- **Schedule Management:** Easily view, manage, and update daily appointment schedules.
- **Patient Records:** Access detailed patient history and medical reports securely.
- **Prescription System:** Create and share digital prescriptions directly with patients.
- **Earnings Tracker:** Monitor consultations and track revenue efficiently.
- **In-App Chat:** Secure communication with patients for follow-ups and queries.

### 🤒 For Patients
- **AI Symptom Checker:** Get initial insights and recommendations based on reported symptoms.
- **Appointment Booking:** Browse available doctors and book consultations seamlessly.
- **Medical Reports:** Safely store and access personal health records and test results.
- **Digital Wallet:** Convenient integrated payment system for medical services.

## Tech Stack
- **Framework:** Flutter (>=3.10.4)
- **Routing:** `go_router` for declarative navigation
- **Backend & Auth:** Firebase Core & Firebase Authentication (Email/Password, Google Sign-In)
- **UI & Styling:** Material Design 3, Google Fonts, Cupertino Icons
- **Networking:** `http` package for RESTful API calls

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.4)
- Dart SDK
- Android Studio / Xcode for emulators
- A Firebase project configured for Android/iOS

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd MedLink
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Ensure your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are placed in the appropriate directories.
   - You may need to generate SHA-1 and SHA-256 fingerprints and add them to your Firebase console to enable Google Sign-In.

4. **Run the App:**
   ```bash
   flutter run
   ```

## Architecture highlights
- **Role-based Navigation:** Uses `go_router` to handle distinct routing paths for `doctor` and `patient` flows.
- **Modular Structure:** Separated into `screens`, `widgets`, `services`, `models`, and `theme` directories for easy maintenance and scalability.

## License
This project is proprietary.
