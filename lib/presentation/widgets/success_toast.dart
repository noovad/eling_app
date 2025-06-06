import 'package:eling_app/presentation/utils/result_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appToast/app_simple_toast.dart';

class SuccessToast {
  static void show(BuildContext context, ForAction action) {
    String message;
    Color backgroundColor = Colors.black;

    switch (action) {
      case ForAction.save:
        message = 'Data saved successfully!';
        break;
      case ForAction.update:
        message = 'Data updated successfully!';
        break;
      case ForAction.delete:
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
