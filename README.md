from pathlib import Path

readme_content = """
# ✨ Doodle — Flutter MVVM App

<p align="center">
  <img src="https://user-images.githubusercontent.com/your-username/doodle/splash_screenshot.png" alt="Splash Screen" width="250"/>
  <img src="https://user-images.githubusercontent.com/your-username/doodle/login_screenshot.png" alt="Login Screen" width="250"/>
  <img src="https://user-images.githubusercontent.com/your-username/doodle/home_screenshot.png" alt="Home Screen" width="250"/>
</p>

---

## 🚀 Project Overview

**Doodle** is a clean, MVVM-structured Flutter app featuring:
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
