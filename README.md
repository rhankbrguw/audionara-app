# AudioNara

Vibe-based music streaming app. Select a mood, stream matching tracks. Built with a Go backend (iTunes Search API proxy) and a Flutter client with a persistent global player.

## Stack

| Layer | Technology |
|---|---|
| Backend | Go 1.24, net/http, Air, PostgreSQL 16, Docker |
| Frontend | Flutter 3, BLoC, go_router, audioplayers, Isar |

## Prerequisites

- Go 1.24+, Flutter 3.x, Docker Compose
- **Linux only:** `sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev gstreamer1.0-plugins-good gstreamer1.0-plugins-bad`

## Setup

```bash
git clone https://github.com/rhankbrguw/audionara-app.git
cd audionara-app

cp backend/.env.example backend/.env
# Set DB_PASSWORD in backend/.env

docker compose up -d

cd frontend
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

> Use `10.0.2.2` for Android emulators. Use your machine's local IP for physical devices.

## API

| Method | Endpoint |
|---|---|
| GET | `/health` |
| GET | `/api/v1/tracks/search?term={vibe}&limit={n}&quality={kbps}` |

## Environment Variables

See `backend/.env.example` for the full reference. Required: `DB_PASSWORD`.
