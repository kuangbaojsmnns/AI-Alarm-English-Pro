# AI Alarm English Pro

An AI-powered English learning alarm application for Windows. It pairs a gentle wake-up experience with short English practice tailored to the learner.

## Development

Requirements: Node.js 20 or newer.

```bash
npm install
npm run dev
```

This starts the Vite development server and opens the Electron desktop window.

Build the web UI and launch the built desktop shell with:

```bash
npm run build
npm start
```

## Project status

The current app is an early UI scaffold built with React, TypeScript, Vite, and Electron. The morning dashboard demonstrates a sample lesson, phrase reveal, lesson start state, and alarm toggle. Lesson content and alarm state are demo-only; Windows alarm scheduling, notifications, speech, and AI generation are not connected yet.

## Planned foundation

- Windows desktop shell with context isolation and a minimal preload bridge
- Learner profile and persistent alarm settings
- Reliable Windows alarm and notification behavior
- Speech playback and level-aware lesson generation through a server-side API
- Accessibility, localization, and quality checks
