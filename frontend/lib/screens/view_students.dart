import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  List students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  // 📄 Fetch students
  void fetchStudents() async {
    var data = await ApiService.getStudents();
    setState(() {
      students = data;
    });
  }

  // ❌ Delete student
  void deleteStudent(int id) async {
  bool success = await ApiService.deleteStudent(id);

  if (!mounted) return; // 🔥 important fix

  if (success) {
    fetchStudents();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Deleted successfully")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Students")),
      body: students.isEmpty
          ? Center(child: Text("No Students Found"))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                var s = students[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(s['name']),
                    subtitle: Text(
                        "${s['branch']} | ${s['course']} \n${s['email']}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteStudent(s['id']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}