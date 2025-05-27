import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appToast/app_simple_toast.dart';

enum FailureAction { save, update, delete }

class FailureToast {
  static void show(BuildContext context, FailureAction action) {
    String message;
    Color backgroundColor = Colors.red;

    switch (action) {
      case FailureAction.save:
        message = 'Failed to save data!';
        break;
      case FailureAction.update:
        message = 'Failed to update data!';
        break;
      case FailureAction.delete:
        message = 'Failed to delete data!';
        break;
    }

    AppSimpleToast.show(
      context,
      child: Text(message, style: TextStyle(color: Colors.white)),
      position: ToastPosition.bottomLeft,
      duration: Duration(seconds: 2),
      backgroundColor: backgroundColor,
    );
  }
}
