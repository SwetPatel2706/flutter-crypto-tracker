# 📈 CryptoPulse

A modern, high-performance, and visually stunning Flutter application for tracking cryptocurrency markets in real-time.

---

## ✨ Features

- **🌐 Real-Time Market Feed**: Live updates for the top 50 cryptocurrencies sourced directly from the **CoinGecko API**.
- **📊 Interactive Charts**: 24-hour price trends visualized using clean, interactive sparkline charts powered by `fl_chart`.
- **⭐ Personalized Watchlist**: Save and monitor your favorite assets persistently using `shared_preferences`.
- **📰 Live Crypto News**: Stay updated with a curated, live RSS news feed from Cointelegraph, parsed automatically.
- **👤 User Profiles**: Customize your profile details (username, email, bio) with local state synchronization.
- **🌌 Immersive Dark UI**: A sleek, premium dark-themed design system featuring Google Fonts typography and subtle glassmorphic elements.

---

## 🛠️ Technology Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/) (Dart SDK `^3.10.3`)
- **State & Storage**: `shared_preferences` for watchlist persistence and persistent settings.
- **HTTP client**: `http` for connecting to the CoinGecko API & RSS2JSON parser.
- **Charts**: `fl_chart` for highly customizable, hardware-accelerated trend lines.
- **Typography**: `google_fonts` for premium typography rendering.
- **Deep Linking**: `url_launcher` to browse full-text news articles seamlessly.

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

Ensure you have the Flutter SDK installed. If not, follow the official [Flutter Installation Guide](https://docs.flutter.dev/get-started/install).

Verify your setup:
```bash
flutter doctor
```

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/SwetPatel2706/flutter-crypto-tracker.git
   cd flutter-crypto-tracker
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   - Launch your favorite simulator/emulator or connect a physical device.
   - Run the following command:
     ```bash
     flutter run
     ```

---

## 📂 Project Structure

```text
lib/
├── core/          # Theme configurations, styling tokens, and constants
├── models/        # Data models (Coin, NewsArticle, etc.)
├── screens/       # UI screens (Login, Dashboard, Market, Watchlist, News, Profile)
├── services/      # API integrations, News parser, Watchlist manager, and User state
└── widgets/       # Shared reusable UI widgets (Chart cards, list items, headers)
```
