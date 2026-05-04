# SCREEN MAP

| Screen | Route | Purpose | Main Action | Output |
|---|---|---|---|---|
| HomePage | / | Explain product value | Start Your App Blueprint | Routes to /app |
| BlueprintForm | /app | Collect project data | Submit blueprint intake | Saves blueprintFormData |
| BlueprintViability | /system/viability | Judge project strength | Continue to results | Shows score and verdict |
| BlueprintResults | /system/results | Show executive result | Download package | Triggers ZIP |
| BlueprintDeliveryPackage | inside /system/results | Deliver product | Download ZIP | 11-file ZIP |
| PricingPage | /pricing | Monetization gate | Choose plan | Routes to payment |
| PaymentSuccessPage | /payment-success | Activate purchase | Confirm access | Routes back to app |
---
## 🔍 INPUT / OUTPUT LOGIC

### BlueprintForm
Input:
- project idea
- target user
- product type

Output:
- blueprintFormData stored

### BlueprintViability
Input:
- blueprintFormData

Output:
- decision (BUILD / FIX / KILL)

### BlueprintResults
Input:
- blueprintFormData + result

Output:
- structured blueprint + ZIP trigger
