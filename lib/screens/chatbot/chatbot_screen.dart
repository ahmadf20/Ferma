import 'package:ferma/controllers/chatbot_controller.dart';
import 'package:ferma/models/chatbot_model.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatebotScreen extends StatefulWidget {
  ChatebotScreen({Key? key}) : super(key: key);

  @override
  _ChatebotScreenState createState() => _ChatebotScreenState();
}

class _ChatebotScreenState extends State<ChatebotScreen> {
  ScrollController? scrollController;

  void scrollToBottom() {
    scrollController?.animateTo(
      0,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ChatbotController>(
        init: ChatbotController(),
        builder: (s) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: MyAppBar(
                title: 'ChatBot',
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.only(left: 25, right: 25),
                //   child: AppTitleBar(
                //     title: 'Chatbot',
                //   ),
                // ),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.all(25),
                    itemCount: s.messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Chat item = s.messages[index];
                      return _buildChatItem(
                        context,
                        item.text ?? '',
                        isUser: item.recipientId == '0',
                      );
                    },
                  ),
                ),

                if (s.isLoading.value)
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Text('Ferma is typing ...'),
                  ),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 25),
                  child: MyTextField(
                    hintText: 'Type your message...',
                    controller: s.controller,
                    inputTextStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 3,
                    suffix: GestureDetector(
                      child: Icon(
                        Icons.send_outlined,
                        size: 18,
                        color: MyColors.grey,
                      ),
                      onTap: () {
                        s.getResponse(s.controller.text, scrollToBottom);
                        s.controller.clear();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Align _buildChatItem(
    BuildContext context,
    String text, {
    bool isUser = true,
  }) {
    return Align(
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? MyColors.lightGreen : MyColors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(7),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 2 / 3,
          minWidth: 100,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? MyColors.primary : MyColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
