import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<bool> submitData(String title, String description) async {
    try {
      final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };
      const url = "https://api.nstack.in/v1/todos";
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateData(
      String id, String title, String description) async {
    try {
      final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };

      final url = "https://api.nstack.in/v1/todos/$id";
      final uri = Uri.parse(url);
      final response = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Hello ki hal hai ${response.body}');
        return false;
      }
    } catch (e) {
      print('baber ${e}');
      return false;
    }
  }

  Future<bool> deleteById(String id) async {
    try {
      final url = "https://api.nstack.in/v1/todos/$id";
      final uri = Uri.parse(url);
      final response = await http.delete(uri);
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
