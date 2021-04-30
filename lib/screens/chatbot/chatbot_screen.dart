import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/app_title_bar.dart';
import 'package:ferma/widgets/my_app_bar.dart';
import 'package:ferma/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class ChatebotScreen extends StatelessWidget {
  const ChatebotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MyAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: AppTitleBar(
              title: 'Chatbot',
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(25),
              children: [
                _buildChatItem(context,
                    ' jadslkfjasldkjf ;lasdj fl;skdjfl;ksdjlfkjads;lfkdlsj  lkjsdl;fksld fl;sdklsdk j ksd lsdk lsdk fsdl;fsd'),
                _buildChatItem(context, 'Test123'),
                _buildChatItem(context, 'ASDF', isUser: false),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
            child: MyTextField(
              hintText: 'Type your message...',
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
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
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
            color: isUser ? MyColors.primary : MyColors.grey,
          ),
        ),
      ),
    );
  }
}
