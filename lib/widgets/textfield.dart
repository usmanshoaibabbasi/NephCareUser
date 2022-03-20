import 'package:flutter/material.dart';
import 'package:neph_care_user/constants/colors.dart';

InputDecoration inputField1(
    {required String label1,
    BuildContext? context,
    Widget? suffixIcon,
    Widget? prefixicon}) {
  return InputDecoration(
    alignLabelWithHint: true,
    contentPadding: const EdgeInsets.fromLTRB(10, 18, 10, 18),
    errorStyle: const TextStyle(),
    prefixIcon: prefixicon,
    suffixIcon: suffixIcon,

    focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: basicthemecolor,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: basicthemecolor,
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: basicthemecolor,
        )),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: basicthemecolor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15.0))),
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(
      color: HexColor('#bbb'),
      height: 1,
    ),
    label: Text(
      label1,
      style: TextStyle(
        color: basicthemecolor,
      ),
    ),
  );
}
