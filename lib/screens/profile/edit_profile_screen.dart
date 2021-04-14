import 'dart:io';

import 'package:ferma/widgets/app_title_bar.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/controllers/edit_profile_controller.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/my_app_bar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<EditProfileController>(
      init: EditProfileController(),
      builder: (s) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: MyAppBar(
              centerTitle: false,
              leading: IconButton(
                icon: Image.asset(
                  'assets/icons/close-outline.png',
                  width: 28,
                  height: 28,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              actions: [
                IconButton(
                  icon: Image.asset(
                    'assets/icons/check-circle.png',
                    width: 28,
                    height: 28,
                  ),
                  onPressed: s.saveHandler,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 55),
            children: [
              AppTitleBar(title: 'Edit Profile'),
              Container(
                width: 90,
                height: 90,
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: buildProfileImg(s),
                ),
              ),
              SizedBox(height: 13),
              GestureDetector(
                onTap: s.pickImage,
                child: Text(
                  'Edit Picture',
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColors.grey,
                  ),
                ),
              ),
              SizedBox(height: 35),
              MyTextField(
                label: 'Email Address',
                controller: s.emailTC,
                validator: (val) {
                  if (!(val?.isEmail ?? false)) {
                    return 'Enter a valid email adress';
                  }
                },
              ),
              SizedBox(height: 12.5),
              MyTextField(
                label: 'Full Name',
                controller: s.nameTC,
              ),
              SizedBox(height: 12.5),
              MyTextField(
                label: 'Username',
                controller: s.usernameTC,
              ),
              SizedBox(height: 12.5),
              MyTextField(
                label: 'Password',
                controller: s.passTC,
                obscureText: true,
                validator: (val) {
                  if (s.passTC!.text.isEmpty) return 'Password cannot be empty';
                },
              ),
              SizedBox(height: 12.5),
              MyTextField(
                  label: 'Re-Type Password',
                  controller: s.repassTC,
                  obscureText: true,
                  validator: (val) {
                    if (s.passTC!.text != s.repassTC!.text) {
                      return 'Password don\'t match';
                    }
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget buildProfileImg(EditProfileController s) {
    if (s.pickedFilePath.value.isNotEmpty) {
      return Image.file(
        File(s.pickedFilePath.value),
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    } else if (s.user.value.profilePicture != null &&
        s.user.value.profilePicture!.isNotEmpty) {
      return loadImage(s.user.value.profilePicture);
    } else {
      return Image.asset(
        'assets/images/default_profile_picture.png',
        width: 90,
        height: 90,
      );
    }
  }
}
