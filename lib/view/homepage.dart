import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/Provider/connectivity.dart';
import 'package:todo_with_provider/utils/routes/routes_name.dart';
import 'package:todo_with_provider/view/todo_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    if (!connectivityProvider.isDeviceConnected) {
      connectivityProvider.showDialogBox();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 231, 237, 222),
        elevation: 0,
      ),
      body: TodoListScreen(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("ADD Todo"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.form);
        },
        backgroundColor: const Color.fromARGB(255, 231, 237, 222),
      ),
    );
  }
}
