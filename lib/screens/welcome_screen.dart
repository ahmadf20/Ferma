import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/utils/themes.dart';
import 'package:ferma/widgets/my_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: mySystemUIOverlaySyle.copyWith(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/welcome_screen_image.jpg',
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + 45),
                    Text(
                      "FERMA",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        color: MyColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                      "The love of gardening is a seed once sown that never dies. — Gertrude Jekyll",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 14,
                        color: MyColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 22),
                    MyOutlineButton(
                      text: 'Get Started',
                      color: Colors.white,
                      onPressed: () {
                        Get.to(() => AuthScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
