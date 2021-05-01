import 'package:ferma/models/myplant_model.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';

class ChecklistListItem extends StatelessWidget {
  const ChecklistListItem({
    Key? key,
    required this.item,
    this.showDesc = true,
    required this.onPressed,
  }) : super(key: key);

  final Checklist item;
  final bool showDesc;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? '-',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MyColors.darkGrey,
                  ),
                ),
                if (showDesc) ...[
                  SizedBox(height: 2.5),
                  Text(
                    item.description ?? '-',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12,
                      color: MyColors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            splashColor: MyColors.grey,
            icon: Image.asset(
              item.isChecked!
                  ? 'assets/icons/check_true.png'
                  : 'assets/icons/check_false.png',
              width: 20,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
