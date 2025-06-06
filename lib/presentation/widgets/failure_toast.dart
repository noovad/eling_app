import 'package:eling_app/presentation/utils/result_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appToast/app_simple_toast.dart';

class FailureToast {
  static void show(BuildContext context, ForAction action) {
    String message;
    Color backgroundColor = Theme.of(context).colorScheme.error;

    switch (action) {
      case ForAction.save:
        message = 'Failed to save data!';
        break;
      case ForAction.update:
        message = 'Failed to update data!';
        break;
      case ForAction.delete:
        message = 'Failed to delete data!';
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
