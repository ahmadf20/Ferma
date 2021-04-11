import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_colors.dart';

ThemeData themeData = ThemeData(
  primaryColor: MyColors.canvas,
  canvasColor: MyColors.canvas,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  accentColor: MyColors.grey,
);

SystemUiOverlayStyle mySystemUIOverlaySyle = SystemUiOverlayStyle(
  systemNavigationBarColor: MyColors.canvas, // navigation bar color
  systemNavigationBarDividerColor: Colors.black26,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.transparent, // status bar color
);
