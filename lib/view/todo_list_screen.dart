import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_with_provider/network/Helper/apis.dart';
import 'package:todo_with_provider/utils/routes/routes_name.dart';
import 'package:todo_with_provider/utils/snakbar_service.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  ApiService apiService = ApiService();
  late List<Map<String, dynamic>> items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const url = "https://api.nstack.in/v1/todos?page=1&limit=20";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final jsonList = jsonResponse['items'] as List<dynamic>;
      final result = List<Map<String, dynamic>>.from(jsonList);
      setState(() {
        items = result;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchData,
      child: Visibility(
        visible: _isLoading || items.isNotEmpty,
        replacement: Center(
          child: Text(_isLoading ? 'Loading...' : 'No To-Do Items'),
        ),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            print("Baber");
            final item = items[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                subtitle: Text(item['description']),
                trailing: PopupMenuButton(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      Navigator.pushNamed(
                        context,
                        RoutesName.editForm,
                        arguments: {
                          'title': item['title'],
                          'description': item['description'],
                          'itemId': item['_id']
                        },
                      );
                    } else if (value == 'delete') {
                      // Delete logic
                      final isSuccess =
                          await apiService.deleteById(item["_id"]);
                      if (isSuccess) {
                        // ignore: use_build_context_synchronously
                        SnackBarService.showSuccessMessage(
                            context, 'Deletion Success');
                      } else {
                        // ignore: use_build_context_synchronously
                        SnackBarService.showErrorMessage(
                            context, 'Deletion failed');
                      }
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
