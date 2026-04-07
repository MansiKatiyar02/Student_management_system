import 'package:flutter/material.dart';
import 'add_student.dart';
import 'view_students.dart';
import 'update_student.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E6FA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Student Management System",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildButton("Add Student", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddStudent()));
              }),
              const SizedBox(height: 15),

              buildButton("Update Student Detail", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UpdateStudent()));
              }),
              const SizedBox(height: 15),

              buildButton("View Database", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ViewStudents()));
              }),
              const SizedBox(height: 15),

              buildButton("Logout", () {
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}