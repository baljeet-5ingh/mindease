# Mindease

## Overview

Mindease is a privacy-first, real-time emotional insight platform built with Next.js and Prisma. It ingests webcam and IoT data, applies lightweight face-expression models (client-side), analyzes emotional signals on the server, and delivers dashboards and assistant features for mental-wellbeing support and situational awareness.

Key goals:

- Provide low-latency emotion detection and visualization.
- Offer a modular API for ingestion, simulation, and assistant features.
- Keep model assets local to the app for offline-first evaluation.

## Features

- Real-time webcam emotion feed and charting.
- Server-side evaluation and insight generation.
- Assistant API for conversational support and recommendations.
- IoT ingestion endpoints for external sensors.
- Prisma-based persistence for optional data storage.

## Repository Structure (high level)

- `app/` — Next.js app routes, pages, and API routes.
- `components/` — UI components and client modules (camera feeds, charts, dashboard UI).
- `lib/` — shared utilities (realtime, state evaluation, helpers).
- `prisma/` — Prisma schema and DB-related files.
- `public/models/` — pretrained weight manifests for face-expression and detector models.
- `services/` — SQL scripts and Prisma helper wrappers.
- `server.js` — custom server entry (if used outside Next's built-in server).

## Tech Stack

- Frontend: Next.js (App Router), React, TypeScript
- Backend: Next.js API Routes (serverless/edge-ready), Node.js
- Database: Prisma (Postgres / SQLite compatible)
- ML: Client-side Tiny Face Detector and face-expression models (weights in `public/models/`)

## Notable API Routes

- `api/assistant/route.ts` — conversational assistant endpoint.
- `api/emotion/ingest/route.ts` — general emotion ingestion pipeline.
- `api/emotion/insight/route.ts` — insight generation.
- `api/get-support/route.ts` — support resource endpoint.
- `api/iot/ingest/route.ts` — IoT sensor ingestion.

Check the `app/api/` folder for the full list and implementation details.

## Setup & Development

1. Install dependencies:

```bash
npm install
```

2. Create a `.env` file at the project root. Common variables:

- `DATABASE_URL` — Prisma connection string (e.g., `postgres://...` or `file:./dev.db`).
- Any API keys required by assistant integrations (if enabled).

3. Run Prisma migrations (if using a database):

```bash
npx prisma migrate dev
```

4. Start the development server:

```bash
npm run dev
```

The app will be available at `http://localhost:3000` by default.

## Model Assets

Pretrained model manifests are stored in `public/models/` (e.g., `face_expression_model-weights_manifest.json`). These are used by client-side face detectors and expression classifiers. Ensure these files are present when testing the camera feed.

## Running Production Build

```bash
npm run build
npm run start
```

For deployments (Vercel, Netlify, or self-hosted), follow your provider's Next.js deployment guide. Make sure to provision any environment variables and database connections.

## Security & Privacy

- Emotion detection runs client-side by default (models loaded in the browser) to limit raw video exposure to the server.
- If you store any personally identifiable data, secure the database with credentials and follow best practices for data retention and consent.

## Testing & Troubleshooting

- Use the camera demo in `public/ws-test.html` for a quick client-side test.
- Check API logs and Next.js console for server errors.

## Contributing

- Fork the repository, create a feature branch, and open a PR with a clear description.

## Acknowledgements

- Built with Next.js, Prisma, and client-side face-detection models.

## Contact

If you need help presenting this project or want a demo, open an issue or contact the maintainer.

---

File: [README.md](README.md)
