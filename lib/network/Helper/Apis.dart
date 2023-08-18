import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiService {
  static Future<bool> submitData(String title, String description) async {
    try {
      final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };
      final url = "https://api.nstack.in/v1/todos";
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
}

class SnackBarService {
  static void showSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(message,style: const TextStyle(color: Colors.black),),
      backgroundColor:const Color.fromARGB(255, 231, 237, 222),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorMessage(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

