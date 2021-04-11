import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String? body;
  final bool showIcon;
  final bool showDivider;
  final Widget? child;
  final Function? onTap;

  const MyCard({
    Key? key,
    required this.title,
    this.body,
    this.showIcon = true,
    this.showDivider = false,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 20, 15, 20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                offset: Offset(0, 3),
                blurRadius: 35,
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: MyColors.darkGrey,
                    ),
                  ),
                  showDivider ? Divider(height: 35) : SizedBox(height: 5),
                  child ?? Container(),
                  if (body != null)
                    Text(
                      body!,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 13,
                        color: MyColors.grey,
                      ),
                    ),
                ],
              ),
            ),
            if (showIcon)
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: MyColors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
