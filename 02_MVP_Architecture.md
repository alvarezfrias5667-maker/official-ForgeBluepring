# MVP ARCHITECTURE

## Exact Screens

1. HomePage  
Purpose: Explain the offer and route users into the blueprint system.  
Route: /

2. BlueprintForm  
Purpose: Capture project idea, target audience, product type, monetization direction, and execution risk.  
Route: /app and /start-building

3. BlueprintViability  
Purpose: Evaluate whether the project should be built, adjusted, or rejected.  
Route: /system/viability

4. BlueprintResults  
Purpose: Show the executive blueprint result and delivery actions.  
Route: /system/results

5. BlueprintDeliveryPackage  
Purpose: Let the user download the ZIP package and optionally open the GitHub version.  
Rendered inside: BlueprintResults

6. PricingPage  
Purpose: Explain paid access when gating is active.  
Route: /pricing

7. PaymentSuccessPage  
Purpose: Activate access or credits after payment.  
Route: /payment-success

## Exact Flow
Step 1: User lands on HomePage.  
Step 2: User clicks Start Your App Blueprint.  
Step 3: User enters /app.  
Step 4: User completes BlueprintForm.  
Step 5: System stores blueprintFormData and blueprintResult in sessionStorage.  
Step 6: User reaches /system/viability.  
Step 7: User proceeds to /system/results.  
Step 8: User downloads the ZIP package.

## MVP Scope
Build only the journey needed to generate, display, and download the blueprint package.

## Excluded From MVP
- team accounts
- admin dashboards
- analytics dashboards
- subscription management
- marketplace features
- multi-project library unless already stable
