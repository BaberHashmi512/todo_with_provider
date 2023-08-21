
import 'package:flutter/material.dart';

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