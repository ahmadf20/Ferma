import 'package:ferma/screens/home_screen.dart';
import 'package:ferma/utils/logger.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    getSavedToken();
  }

  @override
  Widget build(BuildContext context) {
    return token != null ? HomeScreen() : WelcomeScreen();
  }
}
