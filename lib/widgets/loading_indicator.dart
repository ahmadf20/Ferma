import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator({Color? color}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? MyColors.lightGrey,
      ),
    ),
  );
}
