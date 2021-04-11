import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';

class MyOutlineButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final Color? color;
  final Widget? leading;

  const MyOutlineButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.00,
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: color ?? MyColors.primary,
            width: 1.5,
          ),
          shadowColor: color ?? MyColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed as void Function()?,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: leading,
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: color ?? MyColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
