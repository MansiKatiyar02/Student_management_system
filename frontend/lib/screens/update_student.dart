import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_student.dart';

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({super.key});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {

  final TextEditingController studentId = TextEditingController();
  final TextEditingController name = TextEditingController();

  List results = [];

  // 🔍 Search Student
  void search() async {
    var data = await ApiService.getStudents();

    setState(() {
      results = data.where((s) =>
          s['student_id'] == studentId.text &&
          s['name'].toLowerCase() == name.text.toLowerCase()
      ).toList();
    });
  }

  // ❌ Delete Student with confirmation
  void delete(int id) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      bool success = await ApiService.deleteStudent(id);

      if (!mounted) return;

      if (success) {
        search();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Deleted successfully")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E6FA),
        centerTitle: true,
        title: const Text(
          "Update Student",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView( // 👈 prevents overflow
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [

                // 🔹 Input Fields
                TextField(
                  controller: studentId,
                  decoration: InputDecoration(
                    labelText: "Student ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 🔍 Search Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text("Search Student",
                      style: TextStyle(color: Colors.white)
                      ),
                  ),
                ),

                const SizedBox(height: 15),

                // 📄 Results
                ...results.map((s) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(s['name']),
                    subtitle: Text("${s['course']} | ${s['branch']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // ⚙️ UPDATE
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddStudent(student: s), // ✅ FIXED
                              ),
                            );
                          },
                        ),

                        // 🗑️ DELETE
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => delete(s['id']),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}