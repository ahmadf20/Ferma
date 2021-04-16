import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';

class FilterTag extends StatelessWidget {
  final String text;
  final groupValue;
  final value;
  final Function(dynamic) onPressed;

  const FilterTag({
    Key? key,
    required this.text,
    required this.groupValue,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isActive = (groupValue == value);
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          primary: MyColors.primary,
          backgroundColor: isActive ? MyColors.primary : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: isActive ? MyColors.primary : Colors.grey[300]!,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : MyColors.darkGrey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () => onPressed(value),
      ),
    );
  }
}
