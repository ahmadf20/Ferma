import 'package:ferma/models/chatbot_model.dart';
import 'package:ferma/services/chatbot_service.dart';
import 'package:ferma/utils/const.dart';
import 'package:ferma/utils/custom_bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class ChatbotController extends GetxController {
  RxList<Chat> messageList = <Chat>[].obs;
  RxBool isLoading = false.obs;

  final TextEditingController controller = TextEditingController();

  List<Chat> get messages => messageList.reversed.toList();

  void getResponse(String text, Function() callback) async {
    if (text.isEmpty) return;

    messageList.add(Chat(text: text, recipientId: '0'));
    callback();

    isLoading.toggle();

    try {
      await ChatbotService.getResponse(text).then((res) {
        if (res is List<Chat>) {
          messageList.addAll(res);
          callback();
        } else {
          customBotToastText(res);
        }
      });
    } catch (e) {
      customBotToastText(ErrorMessage.general);
    } finally {
      isLoading.toggle();
    }
  }
}
