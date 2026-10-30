# easymove

one app for all services

# EasyMove Mobile Application - Project Assessment Report

## 1. Architecture & Tech Stack
- Framework: Flutter
- Architecture: Clean Architecture
- State Management: BLoC / Cubit
- Networking: HTTP with Bearer Token authorization
- Target Scope: Real Estate module and Core Authentication

---

## 2. Functional & Working Features

### Authentication & Authorization
- Login Validation:
  - Validates credentials against the authentication endpoint.
  - On successful token ID response, navigates to the Home Screen.
  - On invalid credentials (token missing or 401), displays: "Please enter a valid email address and password."
- Account Creation:
  - "Create an Account" tab is active and registers new users.
- Session Management & Logout:
  - Token is preserved and managed via Cubit.
  - Navigation drawer (sidebar) Logout button triggers an authenticated POST request with the Bearer token to invalidate the session.

### Onboarding & Category Routing
- Onboarding flow is operational.
- Service Dashboard:
  - The "Real Estate" card is active and routes directly to the Login/Auth screen.
  - Other service cards (Cars, Flights, Short Stays) are kept inactive to focus on the real estate scope.
- Bottom Navigation Bar:
  - The "Services" tab is functional and interactive.

### Real Estate Home Screen & API Integration
- Exclusively integrated with the Real Estate Listings endpoint (`/api/app/real-estate-listings`).
- No secondary or non-real estate APIs (e.g., cars, flights) are called.
- Dynamically parses and displays listing cards with:
  - Property / Apartment Name
  - Price
  - Location
  - Bedroom count
- Image Handling & Network Resilience:
  - Implemented an `errorBuilder` fallback mechanism. Because the backend image paths currently return HTTP 404 on the host machine, the UI gracefully renders a structured placeholder card rather than breaking or crashing.

---

## 3. UI-Only / Incomplete Components (Scope Boundaries)
- Reset Password: UI screen is built and routed, but not wired to an active backend endpoint.
- User Profile: UI screen structure is present; data binding and profile editing remain unintegrated.
- Sidebar Navigation: Only the Logout action is functional; secondary drawer links are placeholders.
- Additional Service Categories: Non-real estate verticals (cars, flights) remain out of scope for this assessment submission.
