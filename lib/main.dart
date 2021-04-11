import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import 'base_widget.dart';
import 'utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(mySystemUIOverlaySyle);

    return GetMaterialApp(
      title: 'Ferma',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: BaseWidget(),
    );
  }
}
