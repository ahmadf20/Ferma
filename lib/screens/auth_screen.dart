import 'package:bot_toast/bot_toast.dart';
import 'package:ferma/models/user_model.dart';
import 'package:ferma/screens/home_screen.dart';
import 'package:ferma/services/auth_service.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/utils/shared_preferences.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/my_flat_button.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

enum AuthState { login, register }

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthState state = AuthState.login;

  TextEditingController emailTC = TextEditingController();
  TextEditingController nameTC = TextEditingController();
  TextEditingController usernameTC =
      TextEditingController(text: kDebugMode ? 'afaaiz2' : '');
  TextEditingController passwordTC =
      TextEditingController(text: kDebugMode ? 'pass' : '');

  Future loginHandler() async {
    if (usernameTC.text.isEmpty || passwordTC.text.isEmpty) return;

    BotToast.showLoading();
    await AuthService.login(
      usernameTC.text,
      passwordTC.text,
      callback: (value) {
        if (value != null) SharedPrefs.setToken(value['token']);
      },
    ).then((res) {
      if (res is User) {
        customBotToastText('Login success!');
        Get.offAll(() => HomeScreen());
      } else {
        customBotToastText(res);
      }
    }).whenComplete(BotToast.closeAllLoading);
  }

  Future registerHandler() async {
    if (usernameTC.text.isEmpty ||
        passwordTC.text.isEmpty ||
        nameTC.text.isEmpty ||
        emailTC.text.isEmpty) return;

    BotToast.showLoading();
    Map<String, dynamic> data = {
      'username': usernameTC.text,
      'email': emailTC.text,
      'password': passwordTC.text,
      'name': nameTC.text,
    };
    await AuthService.register(
      data,
      callback: (value) {
        if (value != null) SharedPrefs.setToken(value['token']);
      },
    ).then((res) {
      if (res is User) {
        customBotToastText('Register success!');
        Get.offAll(() => HomeScreen());
      } else {
        customBotToastText(res);
      }
    }).whenComplete(BotToast.closeAllLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Const.appbarHeight),
        child: MyAppBar(),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 22.5),
                  Text(
                    state == AuthState.login ? 'Login' : 'Register',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    state == AuthState.login
                        ? 'Sign to continue learning without any limitation right on your hand'
                        : 'Create your account to start your journey with us',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      color: MyColors.grey,
                    ),
                  ),
                  SizedBox(height: 40),
                  if (state == AuthState.register)
                    Column(
                      children: [
                        MyTextField(
                          label: 'Email Address',
                          controller: emailTC,
                          validator: (val) {
                            if (!(val?.isEmail ?? false)) {
                              return 'Enter a valid email adress';
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        MyTextField(
                          label: 'Full Name',
                          controller: nameTC,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  MyTextField(
                    label: 'Username',
                    controller: usernameTC,
                  ),
                  SizedBox(height: 15),
                  MyTextField(
                    label: 'Password',
                    controller: passwordTC,
                    obscureText: true,
                  ),
                  SizedBox(height: 45),
                  MyFlatButton(
                    text:
                        state == AuthState.login ? 'Sign In' : 'Create Account',
                    onPressed: () {
                      if (state == AuthState.login) {
                        loginHandler();
                      } else {
                        registerHandler();
                      }
                    },
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      state = state == AuthState.login
                          ? AuthState.register
                          : AuthState.login;
                      if (mounted) setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state == AuthState.login
                              ? 'Don\'t have an account?'
                              : 'Already have an account?',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            color: MyColors.darkGrey,
                          ),
                        ),
                        Text(
                          state == AuthState.login ? ' Register' : ' Sign In',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: MyColors.darkGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
