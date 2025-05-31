import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appToast/app_simple_toast.dart';

enum SuccessAction { save, update, delete }

class SuccessToast {
  static void show(BuildContext context, SuccessAction action) {
    String message;
    Color backgroundColor = Colors.black;

    switch (action) {
      case SuccessAction.save:
        message = 'Data saved successfully!';
        break;
      case SuccessAction.update:
        message = 'Data updated successfully!';
        break;
      case SuccessAction.delete:
        message = 'Data deleted successfully!';
        break;
    }

    AppSimpleToast.show(
      context,
      child: Text(message),
      position: ToastPosition.bottomLeft,
      duration: Duration(seconds: 2),
      backgroundColor: backgroundColor,
    );
  }
}
