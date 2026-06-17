# LingoBreeze – Vocabulary Deck

A language-learning companion app to save, organize, and review custom vocabulary cards — built with Flutter and powered by a Node.js + Firestore backend.

<table>
  <tr>
    <td align="center" width="33%">
      <b>Empty State</b><br/><br/>
      <img src="https://github.com/user-attachments/assets/d5718c59-3d11-48d8-9617-143a56a50c92" alt="Empty State" width="100%"/>
    </td>
    <td align="center" width="33%">
      <b>Add Word</b><br/><br/>
      <img src="https://github.com/user-attachments/assets/a29e7113-7000-411d-9679-2186bea66178" alt="Add Word Form" width="100%"/>
    </td>
    <td align="center" width="33%">
      <b>Card Deck</b><br/><br/>
      <img src="https://github.com/user-attachments/assets/17286dc7-a6a6-40ef-8f84-0517ff800ce1" alt="Filled Vocabulary List" width="100%"/>
    </td>
  </tr>
</table>

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Mobile | Flutter + Riverpod (Material 3) |
| Backend | Node.js + Express |
| Database | Google Cloud Firestore |

**Flutter Architecture:** Domain → Data (Models & HTTP) → Presentation (Riverpod Notifiers)

---

## Prerequisites

| Tool | Version |
|------|---------|
| Flutter SDK | 3.x |
| Dart SDK | 3.x |
| Node.js | 18.x |
| Firebase Project | Firestore enabled |

---

## Getting Started

### 1. Run the Backend

```bash
cd backend
npm install
```

Place your Firebase service account credentials file (named exactly `serviceAccountKey.json`) inside the `backend/` folder, then start the server:

```bash
node server.js
```

The API will be available at `http://localhost:3000`.

### 2. Set Your Local IP

Open `mobile/lib/features/vocabulary/data/repositories/vocabulary_remote_datasource.dart` and replace the placeholder with your machine's local network IP (find it via `ip a` / `ifconfig` on macOS/Linux or `ipconfig` on Windows):

```dart
// ⚠️ Replace with your machine's local IP
final String baseUrl = 'http://YOUR_LOCAL_IP_HERE:3000/api';
```

### 3. Run the Flutter App

```bash
cd mobile
flutter clean && flutter pub get
flutter run
```

---

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/vocabulary` | Fetch all vocabulary cards |
| `POST` | `/api/vocabulary` | Add a new vocabulary card |
| `DELETE` | `/api/vocabulary/:id` | Delete a card by ID |

---

## Features

- **Empty state** — illustrated prompt shown when the word list is blank
- **Add word** — modal bottom sheet with mandatory field validation
- **Instant sync** — Riverpod state updates the list immediately on save without a manual reload
- **Pull-to-refresh** — swipe down to fetch the latest cards from Firestore
