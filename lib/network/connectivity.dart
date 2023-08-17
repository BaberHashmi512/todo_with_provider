import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isAlertSet = false;
  late StreamSubscription<ConnectivityResult> subscription;
  var isDeviceConnected = false;
  BuildContext? _context;

  ConnectivityProvider() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (connectivityResult) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && !isAlertSet) {
          showDialogBox();
          isAlertSet = true;
          notifyListeners();
        } else if (isDeviceConnected && isAlertSet) {
          isAlertSet = false;
          notifyListeners();
        }
      },
    );
  }

  void showDialogBox() {
    if (_context != null) {
      showDialog(
        context: _context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text('Please check your internet connection.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
