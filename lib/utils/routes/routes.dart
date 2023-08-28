import 'package:flutter/material.dart';
import 'package:todo_with_provider/utils/routes/routes_name.dart';
import 'package:todo_with_provider/utils/todo.dart';
import 'package:todo_with_provider/view/form.dart';
import 'package:todo_with_provider/view/homepage.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        );
      case RoutesName.form:
        return MaterialPageRoute(
          builder: (BuildContext context) => const FormPage(
            title: "ADD Todo",
            buttonTitle: 'Add Todo',
          ),
        );
      case RoutesName.editForm:
        return MaterialPageRoute(
          builder: (BuildContext context) => FormPage(
            title: "Edit Todo",
            buttonTitle: 'Edit Todo',
            todo: settings.arguments as TodoArguments,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Route Defined"),
            ),
          );
        });
    }
  }
}
