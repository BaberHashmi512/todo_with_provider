import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/Provider/connectivity.dart';
import 'package:todo_with_provider/utils/routes/routes.dart';
import 'package:todo_with_provider/utils/routes/routes_name.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 231, 237, 222)),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.home,
        onGenerateRoute: Routes.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
