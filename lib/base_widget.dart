import 'package:ferma/screens/home_screen.dart';
import 'package:ferma/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/welcome_screen.dart';
import 'utils/shared_preferences.dart';

class BaseWidget extends StatefulWidget {
  BaseWidget({Key? key}) : super(key: key);

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  String? token;

  Future getSavedToken() async {
    token = await SharedPrefs.getToken();
    logger.i(token);
    if (mounted) setState(() {});
  }

  Future<void> getLocationPermission() async {
    // You can can also directly ask the permission about its status.
    if (await Permission.location.isPermanentlyDenied) {
      // The OS restricts access, for example because of parental controls.
      await openAppSettings();
    }

    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print(statuses[Permission.location]);
  }

  @override
  void initState() {
    super.initState();
    getSavedToken();
    getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return token != null ? HomeScreen() : WelcomeScreen();
  }
}
