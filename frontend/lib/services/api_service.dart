import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔗 Change this if using real device
  static const String baseUrl = "http://127.0.0.1:5000";

  // 🔐 LOGIN
  static Future<bool> login(String username, String password) async {
  var res = await http.post(
    Uri.parse("$baseUrl/login"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "username": username,
      "password": password,
    }),
  );

  print("STATUS CODE: ${res.statusCode}");
  print("RESPONSE BODY: ${res.body}");

  return res.statusCode == 200;
}

  // ➕ ADD STUDENT
  static Future<bool> addStudent(
    String studentId,
    String name,
    String branch,
    String course,
    String session,
    String address,
    String email,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/students"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "student_id": studentId,
          "name": name,
          "branch": branch,
          "course": course,
          "session": session,
          "address": address,
          "email": email,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Add Student Error: $e");
      return false;
    }
  }

  // 📄 GET ALL STUDENTS
  static Future<List<dynamic>> getStudents() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/students"),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print("Get Students Error: $e");
      return [];
    }
  }

  // ✏️ UPDATE STUDENT
  static Future<bool> updateStudent(
    int id,
    String name,
    String branch,
    String course,
    String session,
    String address,
    String email,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/students/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "branch": branch,
          "course": course,
          "session": session,
          "address": address,
          "email": email,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update Error: $e");
      return false;
    }
  }

  // ❌ DELETE STUDENT
  static Future<bool> deleteStudent(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/students/$id"),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Delete Error: $e");
      return false;
    }
  }
}