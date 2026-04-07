from flask import Flask, request, jsonify
from config import Config
from models import db, Student
from flask_cors import CORS

app = Flask(__name__)
app.config.from_object(Config)

db.init_app(app)
CORS(app)

# 🔐 Dummy Admin Login
ADMIN_USERNAME = "admin"
ADMIN_PASSWORD = "1234"

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    if data['username'] == ADMIN_USERNAME and data['password'] == ADMIN_PASSWORD:
        return jsonify({"message": "Login successful"}), 200
    return jsonify({"message": "Invalid credentials"}), 401


# ➕ Create Student
@app.route('/students', methods=['POST'])
def add_student():
    data = request.json

    student = Student(
        student_id=data['student_id'],
        name=data['name'],
        branch=data['branch'],
        course=data['course'],
        session=data['session'],
        address=data['address'],
        email=data['email']
    )

    db.session.add(student)
    db.session.commit()

    return jsonify({"message": "Student added"})


# 📄 Read All Students
@app.route('/students', methods=['GET'])
def get_students():
    students = Student.query.all()

    result = []
    for s in students:
        result.append({
            "id": s.id,
            "student_id": s.student_id,
            "name": s.name,
            "branch": s.branch,
            "course": s.course,
            "session": s.session,
            "address": s.address,
            "email": s.email
        })

    return jsonify(result)


# ✏️ Update Student
@app.route('/students/<int:id>', methods=['PUT'])
def update_student(id):
    student = Student.query.get(id)
    data = request.json

    student.name = data['name']
    student.branch = data['branch']
    student.course = data['course']
    student.session = data['session']
    student.address = data['address']
    student.email = data['email']

    db.session.commit()
    return jsonify({"message": "Updated"})


# ❌ Delete Student
@app.route('/students/<int:id>', methods=['DELETE'])
def delete_student(id):
    student = Student.query.get(id)
    db.session.delete(student)
    db.session.commit()

    return jsonify({"message": "Deleted"})


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(debug=True)