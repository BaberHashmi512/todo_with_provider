import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late List<Map<String, dynamic>> items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = "https://api.nstack.in/v1/todos?page=1&limit=10";
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
            final item = items[index];
            final id = item['_id'];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    items[index]['title'],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                subtitle: Text(items[index]['description']),
                trailing: PopupMenuButton(
                  onSelected: (value) async {
                    if (value == 'edit') {
                      // Edit logic
                    } else if (value == 'delete') {
                      // Delete logic
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
