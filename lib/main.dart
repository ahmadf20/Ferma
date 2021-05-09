import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:rxdart/rxdart.dart';

import 'base_widget.dart';
import 'services/push_local_notif.dart';
import 'utils/themes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int? id;
  final String? title;
  final String? body;
  final String? payload;
}

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  await LocalPushNotifService.initialize().then((_) {
    print('Local Push Notif has been initialized!');
  });

  await LocalPushNotifService.createNotificationChannel().then((_) {
    print('Notification channel has been created!');
  });

  WidgetsFlutterBinding.ensureInitialized();

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
