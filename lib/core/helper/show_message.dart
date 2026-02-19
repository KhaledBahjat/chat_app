import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showMessage(
  BuildContext context, {
  String? message,
  String? title,
  DialogType? type,
}) {
  AwesomeDialog(
    context: context,
    dialogType: type ?? DialogType.error,
    animType: AnimType.rightSlide,
    title: title,
    desc: message,
    btnOkOnPress: () {},
  ).show();
}