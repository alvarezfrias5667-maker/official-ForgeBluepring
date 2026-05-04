# API STRUCTURE — FORGEBLUEPRINT (PRO)

## SYSTEM PRINCIPLE
The API is not a feature layer.  
It is a CONTROL layer for execution, payment, and delivery.

It must support ONE thing:
👉 A complete flow from idea → blueprint → payment → delivery.

---

## CORE SERVICES

### documentEngine.js
Role:
Generate the full 11-file blueprint package.

Critical rules:
- Must NEVER output empty files
- Must NEVER use fallback-only content
- Must validate content before ZIP creation

Exports:
- createFinalPackage()
- createBlueprintPackage()
- getDecisionSummaryData()
- getExecutionPromptsData()
- generateDeveloperMarkdown()
- generateRoadmapCSV()

---

### accessResolver.js
Role:
Control user access to blueprint delivery.

Must return:
- hasBlueprintAccess (boolean)
- blueprintCredits (number)
- canDownload (derived)

Logic:
User can download ONLY if:
credits > used

---

### PaymentSuccessPage.jsx
Role:
Bridge between PayPal and system access.

Must:
- read PayPal provider_ref
- update user_access
- increment blueprint_credits
- persist access locally

Must NOT:
- grant access without payment confirmation
- mix blueprint with other product logic

---

## CORE API ENDPOINTS

### POST /api/blueprint/generate
Purpose:
Generate structured blueprint before delivery

Input:
{
  formData: {},
  userContext: {}
}

Output:
{
  blueprint: {},
  decision: "BUILD | FIX | KILL"
}

---

### POST /api/payment/create
Purpose:
Create PayPal order

Output:
{
  approvalUrl: string
}

---

### POST /api/payment/verify
Purpose:
Confirm PayPal payment

Input:
{
  providerRef: string
}

Output:
{
  status: "success",
  creditsAdded: number
}

---

### POST /api/download/log
Purpose:
Track ZIP download

---

## EXECUTION RULES

1. NO analytics endpoints
2. NO admin APIs
3. NO team systems
4. NO marketplace logic
5. NO background jobs
6. NO AI chat endpoints

---

## FAILURE CONDITIONS

System fails if:
- ZIP is generated with empty files
- Payment is accepted but access not granted
- User loses data after payment
- Endpoint returns generic output

---

## SUCCESS CONDITION

User completes:

Input → Result → Payment → ZIP Download

WITHOUT:
- friction
- confusion
- manual intervention

---

## FINAL RULE

The API must protect:

👉 VALUE  
👉 ACCESS  
👉 DELIVERY  

Everything else is noise.

---
## 🔁 REAL FLOW EXECUTION

BlueprintForm → BlueprintResults → documentEngine → ZIP Download

## 📡 EXAMPLE FLOW

User submits:
“Marketplace for pet services”

System:
- processes input
- generates structured blueprint
- returns ZIP package

## 🚫 API LIMITATION RULE

If API does more than:
- generate blueprint
- handle access

→ it is out of MVP scope
