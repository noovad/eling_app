import 'package:eling/core/utils/resource.dart';
import 'package:eling/presentation/widgets/failure_toast.dart';
import 'package:eling/presentation/widgets/success_toast.dart';
import 'package:flutter/material.dart';

enum ForAction { save, update, delete }

class ResultHandler {
  static void handleResult({
    required BuildContext context,
    required Resource<String> result,
    required ForAction action,
    required VoidCallback resetAction,
  }) {
    result.whenOrNull(
      success: (value) {
        SuccessToast.show(context, action);

        if (action == ForAction.delete) {
          if (['transaction', 'note'].contains(value)) {
            Navigator.of(context).pop();
          }
        } else if (action == ForAction.save || action == ForAction.update) {
          if (![
            'account',
            'category',
            'transaction_category',
          ].contains(value)) {
            Navigator.of(context).pop();
          }
        }

        resetAction();
      },
      failure: (_) => FailureToast.show(context, action),
    );
  }
}
