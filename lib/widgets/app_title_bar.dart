import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';

class AppTitleBar extends StatelessWidget {
  final String title;
  final String? desc;
  final EdgeInsets? padding;

  const AppTitleBar({
    Key? key,
    this.title = '',
    this.desc,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 35).copyWith(
        bottom: padding?.bottom,
        left: padding?.left,
        right: padding?.right,
        top: padding?.top,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          if (desc != null)
            Text(
              desc!,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'OpenSans',
                color: MyColors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
