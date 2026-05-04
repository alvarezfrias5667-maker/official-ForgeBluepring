# API STRUCTURE

## Core Principle
Only support the main Blueprint flow. No extra APIs.

## Core Services

### documentEngine.js
Purpose:
Generate the 11-file ZIP package.

Exports:
- createFinalPackage
- createBlueprintPackage
- getDecisionSummaryData
- getExecutionPromptsData
- generateDeveloperMarkdown
- generateRoadmapCSV

### accessResolver.js
Purpose:
Handle access control.

Returns:
- hasBlueprintAccess
- blueprintCredits

### PaymentSuccessPage.jsx
Purpose:
Activate access after PayPal.

Updates:
- user_access table

## Future Endpoints
- POST /api/paypal/create-order
- POST /api/paypal/capture-order
- POST /api/paypal/webhook

## Do Not Build Yet
- admin APIs
- analytics APIs
- team APIs
- marketplace APIs
