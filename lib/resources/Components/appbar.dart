import 'package:flutter/material.dart';

class FrontBar extends StatefulWidget {
  const FrontBar({super.key});

  @override
  State<FrontBar> createState() => _FrontBarState();
}

class _FrontBarState extends State<FrontBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 231, 237, 222),
        elevation: 0,
      ),
    );
  }
}
