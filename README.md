# 🎓 Student Management System

A full-stack Student Management System built using Flutter (Frontend), Flask (Backend), and PostgreSQL (Database).  
This application allows users to perform complete CRUD operations on student records with a clean UI and RESTful API integration.

---

## 🚀 Features

- 🔐 Admin Login System
- ➕ Add Student
- 📄 View Students
- ✏️ Update Student Details (No duplication)
- ❌ Delete Student with confirmation
- 🔍 Search Student
- 🎨 Clean and modern UI (Flutter)
- ⚙️ REST API using Flask
- 🗄️ PostgreSQL database integration

---

## 🛠️ Tech Stack

Frontend:
- Flutter (Dart)

Backend:
- Flask (Python)
- Flask-CORS
- SQLAlchemy ORM

Database:
- PostgreSQL

---

## 📂 Project Structure

Employee_management_system/
│
├── backend/
│   ├── app.py
│   ├── config.py
│   ├── models.py
│   ├── routes.py
│   ├── requirements.txt
│   └── Procfile
│
├── frontend/
│   ├── lib/
│   │   ├── screens/
│   │   └── services/
│
└── README.md

---


###  Backend Setup

cd backend  
python -m venv env  
env\Scripts\activate   (Windows)  
pip install -r requirements.txt  

---

###  Configure Database

Update config.py:

SQLALCHEMY_DATABASE_URI = "postgresql://username:password@localhost:5432/student_db"

---

###  Run Backend

python app.py

---

###  Run Frontend

cd frontend  
flutter run  

---

## 📊 API Endpoints

POST   /login            → Admin Login  
POST   /students         → Add Student  
GET    /students         → Get All Students  
PUT    /students/<id>    → Update Student  
DELETE /students/<id>    → Delete Student  

---

## 👨‍💻 Author

Mansi Katiyar

---

## ⭐ If you like this project, give it a star!
