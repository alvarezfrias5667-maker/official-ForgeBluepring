# Build Guide

## Purpose

This guide explains how to assemble a focused MVP using the ForgeBlueprint™ 8-file structure.

This is a public reference guide.

The dynamic application generates personalized build guides based on the user’s project.

## Build Order

1. Landing
2. Intake
3. Processing
4. Results
5. Delivery
6. Access
7. Payment
8. QA
9. Launch

## Step 1 — Landing

Create a clear landing page with:

- headline
- subheadline
- target user
- problem
- CTA
- proof/trust layer
- GitHub reference link if needed

Do not add:

- pricing overload
- long feature grid
- fake testimonials
- unnecessary animations

## Step 2 — Intake

Create a short form.

Required fields:

- project idea or URL
- target user
- product type
- monetization direction
- known risk or pain

The intake must be fast.

## Step 3 — Processing

Add a lightweight processing screen.

Purpose:

- confirm the system is working
- increase perceived analysis depth
- prepare user for result

Recommended states:

- reading input
- identifying structure
- scoring readiness
- preparing blueprint
- finalizing package

## Step 4 — Results

The results page should show:

- verdict
- score
- primary issue
- next action
- risk
- download section

Avoid:

- dashboard complexity
- vague advice
- too many cards
- unclear CTA

## Step 5 — Delivery

The delivery package must contain exactly:

- 01_Executive_Blueprint.md
- 02_Product_Architecture.md
- 03_Technical_Stack.md
- 04_Supabase_Schema.sql
- 05_Execution_Roadmap.md
- 06_PROM_MAX_PRO_EXECUTION.txt
- 07_Launch_System.md
- 08_Build_Guide.md

Rules:

- no empty files
- no fallback file
- no legacy 11-file structure
- no placeholder content

## Step 6 — Access

Access should be controlled by Supabase.

Recommended table:

user_access

Required fields:

- user_id
- status
- blueprint_access
- blueprint_credits
- blueprint_used
- provider
- provider_ref

## Step 7 — Payment

Payment provider:

PayPal

Rules:

- never expose PayPal secrets in frontend
- verify access after payment
- keep payment return simple
- avoid redirect loops

## Step 8 — QA

Test:

- desktop
- Android
- iPhone
- mobile browser
- slow connection
- refresh after result
- download after payment

## Step 9 — Launch

Launch only after:

- ZIP works
- buttons work
- GitHub link works
- README is clean
- no secrets exist in repo
- app builds successfully

## Final Rule

Do not expand the product until the first u
::contentReference[oaicite:2]{index=2}
ser can complete:

Landing → Input → Result → Download

without support.
