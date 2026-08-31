# Celevo - Celebrity & Cinema Discovery App

<p align="center">
  <strong>Celevo</strong> is a modern Flutter application built for exploring popular celebrities, viewing rich personal details, browsing high-resolution photo galleries with zoom & download capabilities, interacting with an AI cinema assistant, and managing favorite celebrities offline.
</p>

---

## App Overview & Screens

### 1. Home Screen (Popular Celebrities)
- Fetches and displays popular persons from the TMDb API (`/person/popular`).
- Dynamic Responsive Grid layout with smooth infinite scroll pagination.
- Instant search filter and department category pills (Acting, Directing, Writing, Production, etc.).
- Direct favorite toggle button on each card.
- Top AppBar with navigation to Favorites and AI Chat Assistant.

### 2. Person Details Screen
- Calls TMDb Person Details API (`/person/{id}`) and Person Images API (`/person/{id}/images`).
- Strict Null Safety across all fields.
- Parallax Hero header with smooth gradient transitions.
- Quick personal info metrics (Gender, Department, Popularity, Birthday & Age calculation, Place of Birth).
- Expandable Biography section with Read More / Read Less toggles.
- Celebrity Photo Gallery displaying high-res photos.
- Horizontal carousel of Known For movies & TV shows.

### 3. Fullscreen Image Viewer
- Full-screen high-resolution photo viewer.
- Smooth Zoom In / Zoom Out (Pinch & Pan) powered by `photo_view`.
- Download Image to Device Gallery with progress indicator, permissions handling (`gal`), and feedback snackbars.

### 4. AI Cinema Assistant
- Dedicated conversational chat screen.
- Integrated with Google Gemini REST API (`gemini-1.5-flash`).
- Assistant to answer questions about actors, movies, directors, and cinema trivia.
- Clean input bar with smooth keyboard handling.
- Loading indicators while waiting for response, with error retry mechanism.

### 5. Favorites List (Offline Persistence)
- Local persistence using `path_provider` and JSON storage.
- Manage and view saved favorite celebrities offline.
- Real-time synchronization between Home cards, Details screen, and Favorites screen.

---

## Architecture & Project Structure

Celevo follows Clean Architecture principles with feature-first modular decomposition:

```
lib/
├── core/
│   ├── constants/            # API endpoints & keys
│   ├── di/                   # Dependency Injection (GetIt)
│   ├── error/                # Custom exceptions
│   ├── models/               # Data models with JSON serialization
│   ├── network/              # Abstract network client
│   │   ├── api_service.dart  # BaseApiService interface
│   │   ├── dio_client/       # DioApiService & DioConfig
│   │   └── http_client/      # HttpApiService & HttpExceptionHandler
│   ├── repos/                # Repositories (TMDB, Favorites, AI Chat)
│   ├── sizes/                # ScreenUtil sizing utilities
│   └── theme/                # Dark theme & colors
└── features/
    ├── home/                 # Popular Persons feature
    │   ├── cubit/            # popular_persons_cubit.dart & popular_persons_state.dart
    │   ├── view/             # home_view.dart
    │   └── widgets/          # Search bar, filters, cards, and grid
    ├── persons/              # Person Details & Gallery feature
    │   ├── cubit/            # person_details_cubit.dart & person_details_state.dart
    │   ├── view/             # person_view.dart, image_viewer_view.dart
    │   └── widgets/          # Hero header, quick info, bio, gallery, controls
    ├── favorites/            # Favorites feature
    │   ├── cubit/            # favorites_cubit.dart & favorites_state.dart
    │   ├── view/             # favorites_view.dart
    │   └── widgets/          # Favorite cards & empty state
    └── chat/                 # AI Chat feature
        ├── cubit/            # chat_cubit.dart & chat_state.dart
        ├── view/             # chat_view.dart
        └── widgets/          # Input bar & message bubbles
```

### State Management (BLoC / Cubit)
- Built using `flutter_bloc` with **strictly separated State and Cubit files**:
  - `popular_persons_cubit.dart` / `popular_persons_state.dart`
  - `person_details_cubit.dart` / `person_details_state.dart`
  - `favorites_cubit.dart` / `favorites_state.dart`
  - `chat_cubit.dart` / `chat_state.dart`

### Interchangeable HTTP Client Layer
- `BaseApiService` interface enables seamless swapping between **Dio** and **Http Client**:
  ```dart
  // Switch in injection_container.dart:
  const bool useDioClient = true; // Set to false to use HttpApiService
  ```

---

## APIs Used

| Endpoint | Method | URL / Path |
| :--- | :---: | :--- |
| **Popular Persons** | `GET` | `https://api.themoviedb.org/3/person/popular` |
| **Person Details** | `GET` | `https://api.themoviedb.org/3/person/{id}` |
| **Person Images** | `GET` | `https://api.themoviedb.org/3/person/{id}/images` |
| **Gemini AI Chat** | `POST` | `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent` |

---

## Getting Started

### Prerequisites
- Flutter SDK `>=3.12.0`
- Dart SDK `>=3.0.0`

### Installation & Run

1. Clone the repository:
   ```bash
   git clone https://github.com/AbdoTechno/celevo.git
   cd celevo
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

---

## Project Information
- **Project**: ITI Flutter Graduation Project
- **Application**: Celevo
- **State Management**: BLoC / Cubit
- **Theme**: Dark Theme
