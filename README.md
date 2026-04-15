# Medica — Medical Appointment App

> Mobile Development II · Individual Project · Spring 2026  
> Built with Flutter · Firebase · Riverpod · GetIt

---

## App Concept

**Medica** is a full-featured medical mobile application that connects patients with healthcare professionals. Users can discover doctors, book appointments, chat in real time, manage prescriptions, track health metrics, and access emergency services — all from one app.

The app was built as a capstone project for the Mobile Development II course, demonstrating production-level Flutter architecture across a 13-week curriculum.

---

## Features

| Feature | Description |
|---|---|
| 🔐 Authentication | Email/Password login & registration via Firebase Auth |
| 👨‍⚕️ Doctor Catalog | Browse and filter doctors by specialty with real photos |
| 📅 Appointments | Book, view, and cancel appointments with real-time Firestore sync |
| 💬 Chat | Real-time messaging with doctors, message history, video/audio call UI |
| ⭐ Reviews | Write and read patient reviews for doctors with star ratings |
| 💊 Pharmacy | Browse medications via OpenFDA API, add to cart, checkout |
| 🏥 Emergency | Hospital list with filters, SOS button, ambulance call |
| 📰 Articles | Health articles with Covid-19, Diet, and Fitness categories |
| 🧮 BMI Calculator | Height/weight sliders with category and visual scale |
| ⏰ Medicine Reminders | Add medications with dosage, frequency, and time alerts |
| 👤 Patient Card | Personal health profile with blood type, allergies, documents |
| ⚙️ Settings | Dark/light mode, language switcher (EN/RU/KK), About, FAQ, Contact |
| 🌐 Offline Support | Firestore offline persistence + connectivity banner |

---

## Architecture

The project follows **feature-first clean architecture** with a clear separation between domain, data, and presentation layers.

```
lib/
├── core/
│   ├── constants/        # App-wide constants
│   ├── di/               # Dependency injection (GetIt)
│   ├── network/          # Dio client, network info
│   ├── providers/        # Global providers (theme, locale)
│   ├── router/           # go_router with auth guards
│   ├── services/         # Notification, drug image service
│   ├── theme/            # Colors, typography, light/dark themes
│   └── widgets/          # Shared reusable widgets
│
└── features/
    ├── auth/             # Login, register, splash
    ├── doctors/          # Doctor catalog, detail, reviews
    ├── appointments/     # Booking, schedule, calendar
    ├── chat/             # Real-time messaging, call UI
    ├── pharmacy/         # Drug search, cart, checkout
    ├── emergency/        # Hospital list, map, SOS
    ├── patient_card/     # Health profile, documents
    ├── articles/         # Health news feed
    ├── bmi/              # BMI calculator
    ├── reminders/        # Medicine reminder tracker
    ├── reviews/          # Doctor reviews
    └── home/             # Home screen, settings, shell
```

Each feature folder contains:
```
feature/
├── domain/
│   ├── entities/         # Pure Dart business objects
│   ├── repositories/     # Abstract interfaces
│   └── usecases/         # Single-responsibility use cases
├── data/
│   ├── models/           # Firestore/API models extending entities
│   ├── datasources/      # Remote data sources
│   └── repositories/     # Concrete implementations
└── presentation/
    ├── providers/        # Riverpod state providers
    ├── screens/          # UI screens
    └── widgets/          # Feature-specific widgets
```

### Key Architecture Decisions

**Dependency Injection** — All dependencies are registered via `GetIt` in `lib/core/di/injection.dart`. No Firebase or API calls are made directly from UI widgets.

**State Management** — Riverpod is used throughout with `FutureProvider`, `StreamProvider`, `StateNotifierProvider`, and `AsyncNotifier`. Business logic lives exclusively in providers and use cases.

**Navigation** — `go_router` with a `ShellRoute` for the bottom navigation bar and route guards that redirect unauthenticated users to login.

**Cache-then-network** — The pharmacy repository returns cached drug results immediately while fetching fresh data in the background.

---

## APIs Used

### 1. OpenFDA Drug Label API
- **URL:** `https://api.fda.gov/drug/label.json`
- **Auth:** None required
- **Used for:** Searching real drug/medication data in the Pharmacy feature
- **Example:** `GET /drug/label.json?search=openfda.product_type:"OTC"&limit=20`

### 2. Random User API
- **URL:** `https://randomuser.me/api`
- **Auth:** None required  
- **Used for:** Generating realistic doctor profiles (name, photo, specialty)
- **Example:** `GET /api/?results=20`

### 3. RxNorm API (NLM)
- **URL:** `https://rxnav.nlm.nih.gov/REST/rxcui.json`
- **Auth:** None required
- **Used for:** Looking up RxCUI codes for drug names to fetch pill images
- **Example:** `GET /REST/rxcui.json?name=ibuprofen&search=1`

### 4. RxImage API (NLM)
- **URL:** `https://rximage.nlm.nih.gov/api/rximage/1/rxnav`
- **Auth:** None required
- **Used for:** Fetching real pill photographs by RxCUI code
- **Example:** `GET /api/rximage/1/rxnav?rxcui=5640&resolution=600`

### 5. Firebase Services
| Service | Usage |
|---|---|
| Firebase Auth | Email/Password authentication, secure token storage |
| Cloud Firestore | Appointments, chat messages, reviews, reminders, patient data |
| Firebase Storage | Patient document uploads |
| Firebase Messaging | Push notification setup for appointment reminders |

---

## Setup Steps

### Prerequisites
- Flutter SDK `^3.x`
- Dart SDK `^3.9`
- Android Studio or VS Code with Flutter plugin
- Firebase account

### 1. Clone the repository
```bash
git clone https://github.com/<your-username>/md2-individual-project.git
cd md2-individual-project
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Configure Firebase

Install the Firebase CLI and FlutterFire CLI if you haven't already:
```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login
```

Then configure your own Firebase project:
```bash
flutterfire configure
```

This generates:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

> ⚠️ These files are excluded from the repository. Do not commit them.

### 4. Enable Firebase services

In the [Firebase Console](https://console.firebase.google.com):

- **Authentication** → Sign-in methods → Enable **Email/Password**
- **Firestore Database** → Create database → Start in **test mode**
- **Storage** → Get started → Test mode

### 5. Set Firestore security rules

In Firebase Console → Firestore → Rules, paste:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth.uid == userId;
    }
    match /appointments/{doc} {
      allow read, write: if request.auth != null;
    }
    match /patient_cards/{doc} {
      allow read, write: if request.auth != null;
    }
    match /conversations/{userId}/chats/{chatId} {
      allow read, write: if request.auth.uid == userId;
    }
    match /messages/{conversationId}/msgs/{msgId} {
      allow read, write: if request.auth != null;
    }
    match /reviews/{doc} {
      allow read, write: if request.auth != null;
    }
    match /users/{userId}/reminders/{doc} {
      allow read, write: if request.auth.uid == userId;
    }
  }
}
```

### 6. Run the app
```bash
flutter run
```

For a release build:
```bash
flutter build apk --release
```

---

## Rubric Coverage

| Requirement | Implementation |
|---|---|
| Architecture & DI (10 pts) | Feature-first clean architecture, GetIt for all dependencies |
| Navigation & route guards (8 pts) | go_router with ShellRoute, unauthenticated redirect to login |
| State management (12 pts) | Riverpod throughout — loading, error, empty states handled |
| REST API integration (8 pts) | OpenFDA via Dio in data layer with error handling |
| Authentication & security (10 pts) | Firebase Auth, flutter_secure_storage, no keys in repo |
| Firebase Firestore + service (15 pts) | Firestore real-time streams, Firebase Storage for documents |
| Offline-first & performance (10 pts) | Firestore persistence, connectivity_plus offline banner |
| UI/UX quality (12 pts) | Consistent teal design system, light/dark mode, reusable widgets |
| Testing (7 pts) | 6 unit tests in `test/app_test.dart` |
| Code quality & Git hygiene (10 pts) | Feature-first structure, named routes, no business logic in widgets |
| **Localization bonus (+3 pts)** | EN, RU, KK via flutter_localizations |

---

## Localization

The app supports 3 languages switchable from Settings:

| Language | File |
|---|---|
| English | `lib/l10n/app_en.arb` |
| Russian | `lib/l10n/app_ru.arb` |
| Kazakh | `lib/l10n/app_kk.arb` |

---

## Notes for Grader

- `google-services.json` and `firebase_options.dart` are **not included** in the repository and will be shared separately via Canvas as instructed.
- API keys: none required for OpenFDA, RxNorm, or RxImage — all are publicly accessible.
- The screen recording demonstrates: login, doctor booking, real-time chat, pharmacy search, emergency screen, BMI calculator, medicine reminders, and offline behaviour.
