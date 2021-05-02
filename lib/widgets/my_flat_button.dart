import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';

class MyFlatButton extends StatelessWidget {
  @required
  final String text;
  final Function? onPressed;
  final Color? color;
  final Color? textColor;

  const MyFlatButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: TextButton.styleFrom(
          backgroundColor: color ?? MyColors.primary,
          primary: MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: textColor ?? MyColors.white,
          ),
        ),
      ),
    );
  }
}
