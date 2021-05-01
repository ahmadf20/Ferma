import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:ferma/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ferma/controllers/profile/profile_controller.dart';
import 'package:ferma/models/user_model.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';
import 'package:ferma/utils/logger.dart';

class EditProfileController extends GetxController {
  final Rx<User> user = User().obs;

  TextEditingController? emailTC;
  TextEditingController? nameTC;
  TextEditingController? usernameTC;
  TextEditingController? passTC;
  TextEditingController? repassTC;

  final ImagePicker _picker = ImagePicker();
  PickedFile? _pickedFile;
  Rx<String> pickedFilePath = ''.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  void updateUser(User? newUser) {
    user.update((val) {
      if (val != null) {
        val.name = newUser!.name;
        val.email = newUser.email;
        val.id = newUser.id;
        val.location = newUser.location;
        val.profilePicture = newUser.profilePicture;
        val.username = newUser.username;
      }
    });
  }

  void initData() {
    User newUser = Get.find<ProfileController>().user.value;
    updateUser(newUser);

    emailTC = TextEditingController(text: user.value.email);
    nameTC = TextEditingController(text: user.value.name);
    usernameTC = TextEditingController(text: user.value.username);

    passTC = TextEditingController();
    repassTC = TextEditingController();
  }

  RxBool get fieldNotComplete => (usernameTC!.text.isEmpty ||
          emailTC!.text.isEmpty ||
          passTC!.text.isEmpty ||
          repassTC!.text.isEmpty ||
          nameTC!.text.isEmpty)
      .obs;

  Future saveHandler() async {
    if (fieldNotComplete.value) {
      customBotToastText('All fields are required!');
      return;
    }

    if (repassTC!.text != passTC!.text) {
      return;
    }

    BotToast.showLoading();

    if (pickedFilePath.value.isNotEmpty) {
      File file = File(pickedFilePath.value);
      logger.v(file.path);
    }

    Map<String, dynamic> data = {
      'username': usernameTC!.text,
      'email': emailTC!.text,
      'password': passTC!.text,
      'name': nameTC!.text,
    };

    try {
      await UserService.updateUserData(data,
              filepath:
                  (pickedFilePath.value.isEmpty) ? null : pickedFilePath.value)
          .then((res) {
        if (res == true) {
          Get.find<ProfileController>().fetchUserData();
          Get.back();
          customBotToastText('Profile has been updated!');
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Future pickImage() async {
    _pickedFile = await _picker
        .getImage(source: ImageSource.gallery, imageQuality: 80)
        .then((val) {
      if (val != null) {
        pickedFilePath.value = val.path;
        logger.i('Path: ${val}');
      }
      logger.v(_pickedFile?.path);
    }).catchError((e) {
      customBotToastText('Akses photo tidak diizinkan');
      logger.e(e);
    });
  }
}
