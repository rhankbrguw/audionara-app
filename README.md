# AudioNara

A vibe-based music streaming application. Users select or search a mood, and the app streams matching tracks in real time. AudioNara is composed of a Go HTTP backend that proxies the iTunes Search API and a Flutter mobile client with a persistent global player.

---

## Architecture

```
audionara-app/
├── backend/          # Go 1.24 — HTTP API server
│   ├── cmd/server/   # Entry point
│   ├── internal/
│   │   ├── delivery/ # HTTP handlers and route registration
│   │   ├── repository/ # iTunes API integration
│   │   └── usecase/  # Business logic
│   └── pkg/env/      # Environment variable helpers
└── frontend/         # Flutter 3 — Android / iOS / Linux client
    └── lib/
        ├── core/     # Theme, navigation, services, constants
        └── features/ # home, player, playlist, settings, user
```

**Backend stack:** Go 1.24, net/http, Air (hot-reload), PostgreSQL 16, Docker  
**Frontend stack:** Flutter 3, BLoC, go_router, audioplayers, Isar, http

---

## Prerequisites

| Tool | Version |
|---|---|
| Go | 1.24+ |
| Flutter | 3.x (Dart 3.9+) |
| Docker + Docker Compose | any recent stable |
| GStreamer (Linux only) | 1.0 |

**Linux only** — install GStreamer before building the Flutter target:

```bash
sudo apt-get install -y \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad
```

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/rhankbrguw/audionara-app.git
cd audionara-app
```

### 2. Configure environment variables

```bash
cp backend/.env.example backend/.env
```

Open `backend/.env` and set at minimum:

```
DB_PASSWORD=your_postgres_password
APP_PORT=8080
```

### 3. Start the backend stack

```bash
docker compose up -d
```

This starts three containers:

| Container | Port | Description |
|---|---|---|
| `audionara_backend` | 8080 | Go API server with Air hot-reload |
| `audionara_postgres` | 5432 | PostgreSQL 16 database |
| `audionara_pgadmin` | 5050 | pgAdmin 4 web UI |

Verify the server is running:

```bash
curl http://localhost:8080/health
# {"status":"ok"}
```

### 4. Run the Flutter client

```bash
cd frontend
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

> Use `http://10.0.2.2:8080` for Android emulators. Use your machine's local IP for physical devices.

---

## API Reference

Base URL: `http://localhost:8080`

| Method | Endpoint | Description |
|---|---|---|
| GET | `/health` | Health check |
| GET | `/api/v1/tracks/search?term={vibe}&limit={n}&quality={kbps}` | Search tracks by vibe |

**Query parameters for track search:**

| Parameter | Type | Default | Description |
|---|---|---|---|
| `term` | string | required | Mood or vibe keyword |
| `limit` | integer | 25 | Number of results |
| `quality` | integer | 128 | Bitrate preference (64, 128, 256) |

---

## Player Features

- Vibe-based track discovery (search or grid selection)
- Play, pause, seek, next, previous
- Shuffle and repeat modes
- Persistent mini-player on the home screen
- Add to playlist / favorites (local Isar storage)
- Explicit content filter

---

## Development

### Backend hot-reload

The backend container runs [Air](https://github.com/air-verse/air). Any change to a `.go` file inside `backend/` is automatically compiled and restarted inside the container — no manual rebuild required.

### Flutter hot-reload

With a device or emulator connected and `flutter run` active, press `r` for hot-reload or `R` for a full hot-restart.

### Stopping the stack

```bash
docker compose down
```

To also remove all persisted volumes:

```bash
docker compose down -v
```

---

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `APP_PORT` | `8080` | HTTP server port |
| `APP_ENV` | `development` | Runtime environment |
| `DB_HOST` | `localhost` | PostgreSQL host |
| `DB_PORT` | `5432` | PostgreSQL port |
| `DB_NAME` | `audionara` | Database name |
| `DB_USER` | `audionara_user` | Database user |
| `DB_PASSWORD` | — | Database password (required) |
| `JWT_SECRET` | — | Secret key for JWT signing |
| `JWT_EXPIRY_HOURS` | `24` | Token expiry window |

---

## License

This project is private and not licensed for public distribution.
