# AI Alarm English Pro

> Wake up. Speak English. Learn with AI.

AI Alarm English Pro is an AI-powered English learning alarm application designed to transform the first few minutes after waking into an effective daily learning session.

Users complete AI-generated English conversations, vocabulary practice, and pronunciation tasks before dismissing the alarm, building consistent language habits through intelligent interaction.

---

## Features

### Smart AI Alarm

- Alarm that requires task completion before dismissal
- Custom wake-up schedule
- Multiple alarm profiles
- Snooze management
- Smart retry mechanism

### AI English Conversation

- Powered by OpenAI Responses API
- Daily conversation topics
- CEFR level adaptation (A1–C2)
- Grammar correction
- Vocabulary explanation
- Pronunciation feedback (future)

### Vocabulary Learning

- Daily vocabulary goals
- Review mode
- AI-generated example sentences
- Difficulty adjustment
- Learning statistics

### Learning Statistics

- Learning streak
- Alarm completion rate
- Vocabulary progress
- Conversation history
- Weekly and monthly reports

---

## Technology Stack

### Mobile

- Flutter 3.35
- Dart
- Riverpod
- go_router
- Dio
- freezed
- json_serializable

### Backend

- FastAPI
- SQLAlchemy 2.x
- Alembic
- SQLite
- PostgreSQL (future)
- JWT Authentication

### AI

- OpenAI Responses API

### DevOps

- Docker
- Docker Compose
- GitHub Actions

---

## Project Structure

```text
AI-Alarm-English-Pro
├── app/
├── server/
├── docs/
├── .github/
├── docker-compose.yml
├── README.md
└── LICENSE
```

---

## Roadmap

### v0.1.0

- Project bootstrap
- Flutter skeleton
- FastAPI skeleton
- Login
- Home
- OpenAI integration

### v0.2.0

- AI Alarm
- Vocabulary Learning
- Daily Tasks

### v0.3.0

- AI Voice
- Statistics Dashboard
- Cloud Sync

### v1.0.0

- Production Release

---

## License

Released under the MIT License.
