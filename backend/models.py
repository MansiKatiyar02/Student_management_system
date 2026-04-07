from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Student(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.String(50), unique=True, nullable=False)
    name = db.Column(db.String(100))
    branch = db.Column(db.String(100))
    course = db.Column(db.String(100))
    session = db.Column(db.String(50))
    address = db.Column(db.String(200))
    email = db.Column(db.String(100))