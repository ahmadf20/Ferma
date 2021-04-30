import 'package:ferma/utils/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? label;
  final bool obscureText;
  final String? errorText;
  final String? hintText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function? onChanged;
  final TextStyle? inputTextStyle;
  final bool autoFocus;
  final int maxLines;

  const MyTextField({
    Key? key,
    this.label,
    this.obscureText = false,
    this.controller,
    this.errorText,
    this.validator,
    this.hintText,
    this.suffix,
    this.suffixIcon,
    this.onChanged,
    this.fillColor,
    this.inputTextStyle,
    this.autoFocus = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 12.5),
      decoration: BoxDecoration(
        color: fillColor ?? Color(0xffFCFCFC),
        border: Border.all(
          width: 1.00,
          color: Color(0xfff0f0f0),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged as void Function(String)?,
        obscureText: obscureText,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: MyColors.darkGrey,
        ).merge(inputTextStyle),
        minLines: 1,
        maxLines: maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: autoFocus,
        validator: validator,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            fontFamily: 'OpenSans',
            color: MyColors.grey,
            height: 0.8,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: fillColor ?? Color(0xFFF7F5F2),
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          suffix: suffix,
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(maxHeight: 48, minHeight: 24),
          isDense: true,
          labelText: label,
          errorText: errorText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: MyColors.grey,
          ),
        ),
      ),
    );
  }
}
