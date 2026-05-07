# Technical Stack

## Recommended Stack

Frontend:
- React
- Vite
- Tailwind CSS

UI:
- Lucide React
- Radix-style components

Backend:
- Node.js
- Express-compatible API layer

Database:
- Supabase
- PostgreSQL

Authentication:
- Supabase Auth

Payments:
- PayPal

ZIP Delivery:
- JSZip

Hosting:
- Hostinger or Vercel-compatible deployment

## Architecture Priority

The system must prioritize:

- fast loading
- reliable form capture
- stable ZIP delivery
- secure access control
- clean mobile UX

## Frontend Responsibilities

The frontend handles:

- landing experience
- intake forms
- result display
- delivery interface
- download action
- GitHub reference link

## Backend Responsibilities

The backend should handle:

- payment verification
- webhook processing
- access updates
- secure API operations
- future report generation

## Supabase Responsibilities

Supabase stores:

- users
- project submissions
- blueprint metadata
- access status
- download logs

## Security Rules

Never expose:

- SUPABASE_SERVICE_ROLE_KEY
- PAYPAL_CLIENT_SECRET
- PAYPAL_WEBHOOK_ID
- private tokens
- production secrets

## MVP Technical Boundary

Do not add:

- Redux
- complex server orchestration
- analytics dashboard
- team management
- unnecessary integrations

## Production Readiness Checklist

- app builds successfully
- routes load correctly
- Supabase keys are environment-based
- PayPal secrets are server-side
- ZIP downloads on desktop and mobile
- no fallback files appear
- no legacy package files remain
