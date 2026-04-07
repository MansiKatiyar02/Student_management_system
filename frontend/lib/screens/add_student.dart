import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddStudent extends StatefulWidget {
  final Map? student;

  const AddStudent({super.key, this.student});

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  final TextEditingController studentId = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController branch = TextEditingController();
  final TextEditingController course = TextEditingController();
  final TextEditingController session = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();

  bool isUpdate = false;
  int? id;

  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      isUpdate = true;
      id = widget.student!['id'];

      studentId.text = widget.student!['student_id'];
      name.text = widget.student!['name'];
      branch.text = widget.student!['branch'];
      course.text = widget.student!['course'];
      session.text = widget.student!['session'];
      address.text = widget.student!['address'];
      email.text = widget.student!['email'];
    }
  }

  void showTopMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      ),
    );
  }

  void submit() async {
    bool success;

    if (isUpdate) {
      success = await ApiService.updateStudent(
        id!,
        name.text,
        branch.text,
        course.text,
        session.text,
        address.text,
        email.text,
      );
    } else {
      success = await ApiService.addStudent(
        studentId.text,
        name.text,
        branch.text,
        course.text,
        session.text,
        address.text,
        email.text,
      );
    }

    if (success) {
      showTopMessage(isUpdate ? "Updated Successfully" : "Student Added");
      Navigator.pop(context);
    } else {
      showTopMessage("Failed");
    }
  }

  Widget buildField(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E6FA),
        centerTitle: true,
        title: Text(
          isUpdate ? "Update Student" : "Add Student",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // 🔹 Disable Student ID in update mode
                TextField(
                  controller: studentId,
                  enabled: !isUpdate,
                  decoration: InputDecoration(
                    labelText: "Student ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                buildField(name, "Name"),
                buildField(branch, "Branch"),
                buildField(course, "Course"),
                buildField(session, "Session"),
                buildField(address, "Address"),
                buildField(email, "Email"),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      isUpdate ? "Update Student" : "Add Student",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}