# ✨ reqres — Flutter MVVM App

<p align="center">
  <img src="https://raw.githubusercontent.com/AdeebAbubacker/doodle/refs/heads/main/assets/6215174714104594939.jpg" alt="Splash Screen" width="250"/>
  <img src="https://raw.githubusercontent.com/AdeebAbubacker/doodle/refs/heads/main/assets/6215174714104594937.jpg" alt="Login Screen" width="250"/>
  <img src="https://raw.githubusercontent.com/AdeebAbubacker/doodle/refs/heads/main/assets/6215174714104594938.jpg" alt="Home Screen" width="250"/>
</p>

---

## 🚀 Project Overview

**reqres** is a clean, MVVM-structured Flutter app featuring:

- ✅ BLoC/Cubit state management
- ✅ GetIt for dependency injection
- ✅ Screens: Splash → Login → Home
- ✅ REST APIs powered by [reqres.in](https://reqres.in/):
  - `POST /login`
  - `POST /register`
  - `GET /users?page=2`
- ✅ Architected for readability, testability, and professionalism

---

## 📌 Features

- **Splash Screen** — Brand introduction with auto-navigation
- **Authentication Flow** — Login & registration (with error/no-internet handling)
- **Home Screen** — Fetch and display paginated user list with pull-to-refresh
- **Robust Architecture** — MVVM, dependency injection, clean error states

---

## ⚙️ API Endpoints

```bash
# Login
POST https://reqres.in/api/login
{ "email": "eve.holt@reqres.in", "password": "cityslicka" }

# Register
POST https://reqres.in/api/register
{ "email": "eve.holt@reqres.in", "password": "pistol" }

# Get Users
GET https://reqres.in/api/users?page=2
```
