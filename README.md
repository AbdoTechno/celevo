# 🎬 Celevo — Celebrity & Cinema Discovery App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/State_Management-BLoC%20%2F%20Cubit-blueviolet?style=for-the-badge" alt="BLoC" />
  <img src="https://img.shields.io/badge/AI-Google%20Gemini-orange?style=for-the-badge&logo=google" alt="Gemini" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-success?style=for-the-badge" alt="Platform" />
</p>

<p align="center">
  <strong>Celevo</strong> is a cinema and celebrity exploration application built with <strong>Flutter</strong>. It integrates the <strong>TMDb (The Movie Database) API</strong> for celebrity data and filmography, and utilizes <strong>Google Gemini AI</strong> to provide an interactive cinema chatbot assistant.
</p>

---

## ✨ Key Features

### 🌟 1. Home & Discovery (Popular Celebrities)
- **TMDb Integration:** Fetches popular celebrities with dynamic pagination (infinite scroll).
- **Instant Search & Department Filters:** Filter actors, directors, writers, and crew in real time with category pills.
- **Responsive Layout:** Responsive grid with smooth image loading and shimmer placeholders via `cached_network_image`.
- **Quick Favorites Toggle:** Add or remove celebrities directly from their card with instant visual feedback.

### 👤 2. Celebrity Details & Filmography
- **Hero Header:** Parallax header transition with smooth gradient overlays.
- **Key Metrics:** Gender, department, popularity score, birth date, age calculation, and birthplace.
- **Expandable Biography:** Seamless "Read More / Read Less" expandable text.
- **Filmography Carousel:** Horizontal list of "Known For" movies and TV series.
- **High-Res Photo Gallery:** Grid of available celebrity portraits.

### 🖼️ 3. Fullscreen Interactive Photo Viewer
- **Pinch-to-Zoom & Pan:** Smooth gesture zooming powered by `photo_view`.
- **Save to Gallery:** Direct image download to device storage via `gal` with automatic permission handling and feedback SnackBars.

### 🤖 4. AI Cinema Assistant (Google Gemini)
- **Interactive Chat:** Natural language conversations about movies, trivia, casting, and celebrity biographies.
- **Powered by Gemini API:** Uses `gemini-3.6-flash` with automatic fallback to `gemini-3.5-flash-lite` for high uptime.
- **Modern Chat Interface:** Chat bubbles, typing/generating indicators, error recovery, and clear chat option.

### ❤️ 5. Offline Favorites Management
- **Local Persistence:** Saves favorite celebrities locally using `path_provider` and JSON serialization without third-party database overhead.
- **Two-Way Sync:** Synchronized state across Home, Details, and Favorites screens.
- **Empty State UI:** Clean graphics and easy navigation when no favorites are saved.

---

## 🏛️ Architecture & Clean Code

The app follows **Clean Architecture** principles structured by feature:

```
lib/
├── core/
│   ├── constants/             # API constants & endpoints
│   ├── di/                    # Dependency Injection (GetIt service locator)
│   ├── error/                 # Custom error & exception definitions
│   ├── models/                # Data models with JSON serialization
│   ├── network/               # Abstract network layer
│   │   ├── api_service.dart   # BaseApiService interface
│   │   ├── dio client/        # Dio implementation & interceptors
│   │   └── http_client/       # Native HTTP implementation & handler
│   ├── repos/                 # Repositories (TMDb, Favorites, AI Chat)
│   ├── sizes/                 # ScreenUtil sizing utilities
│   └── theme/                 # Dark theme, colors & typography
├── features/
│   ├── home/                  # Popular Celebrities list & filters
│   │   ├── cubit/             # PopularPersonsCubit & PopularPersonsState (Equatable)
│   │   ├── view/              # Home & MainNavScaffold views
│   │   └── widgets/           # Cards, search bar, department pills
│   ├── persons/               # Details & Gallery
│   │   ├── cubit/             # PersonDetailsCubit & PersonDetailsState
│   │   ├── view/              # PersonView & FullscreenImageViewer
│   │   └── widgets/           # Hero header, metrics, bio, gallery
│   ├── favorites/             # Offline Favorites
│   │   ├── cubit/             # FavoritesCubit & FavoritesState
│   │   ├── view/              # FavoritesView
│   │   └── widgets/           # Favorite person cards & empty state
│   └── chat/                  # AI Cinema Assistant
│       ├── cubit/             # ChatCubit & ChatState
│       ├── view/              # ChatView
│       └── widgets/           # Chat bubbles & message input bar
└── main.dart                  # App entrypoint, dotenv & locator initialization
```

### 🔄 Dual Network Client Strategy
Celevo features an interchangeable networking layer through `BaseApiService`. You can switch between **Dio** and **Http Client** simply by toggling a flag in `injection_container.dart`:

```dart
// lib/core/di/injection_container.dart
const bool useDioClient = true; // Set to false to use HttpApiService
```

### ⚡ State Management
- Built using **Bloc / Cubit** (`flutter_bloc`).
- Strict separation between Cubits and States.
- State equality comparison optimized with **`Equatable`** to prevent unnecessary UI rebuilds.

---

## 🔐 Environment Variables Configuration

API keys are securely loaded at runtime using **`flutter_dotenv`** and kept out of version control via `.gitignore`.

1. Copy `.env.example` to create your own `.env` file:
   ```bash
   cp .env.example .env
   ```

2. Open `.env` and insert your credentials:
   ```env
   TMDB_API_KEY=your_tmdb_api_key_here
   GEMINI_API_KEY=your_gemini_api_key_here
   ```

> 💡 **Where to get keys:**
> - **TMDb API Key:** Sign up at [The Movie Database (TMDb)](https://www.themoviedb.org/documentation/api) and create an API Key.
> - **Google Gemini API Key:** Generate a free API Key at [Google AI Studio](https://aistudio.google.com/).

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>=3.12.0`)
- [Dart SDK](https://dart.dev/get-dart) (`>=3.0.0`)
- Android Studio / VS Code with Flutter extension

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AbdoTechno/celevo.git
   cd celevo
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up `.env`:**
   Ensure `.env` exists in the root directory with your keys (as described above).

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🛠️ Tech Stack & Packages

| Package | Purpose |
| :--- | :--- |
| **`flutter_bloc`** | Predictable state management with Cubit |
| **`equatable`** | Value equality comparison for states |
| **`get_it`** | Dependency injection & Service Locator |
| **`dio`** | Powerful HTTP networking with interceptors |
| **`http`** | Lightweight alternative HTTP networking client |
| **`flutter_dotenv`** | Secure environment variables loading |
| **`flutter_screenutil`** | Adaptive screen sizing and responsive UI |
| **`cached_network_image`** | Network image caching and placeholder handling |
| **`photo_view`** | Interactive zoom and pan gesture viewer |
| **`gal`** | Direct photo saving to device gallery |
| **`path_provider`** | Device file system paths for local JSON storage |
| **`google_fonts`** | Typography & custom font integration |

---

## 📄 License & Credits

- Developed as part of the **ITI Flutter Track**.
- Movie & celebrity data provided by **[The Movie Database (TMDb)](https://www.themoviedb.org/)**.
- AI Chat capabilities provided by **[Google Gemini](https://ai.google.dev/)**.
