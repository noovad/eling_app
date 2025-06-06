import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/presentation/widgets/failure_toast.dart';
import 'package:eling_app/presentation/widgets/success_toast.dart';
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
      success: (_) {
        SuccessToast.show(context, action);
        result.whenOrNull(
          success: (value) {
            bool condition =
                value != "account" &&
                value != "transaction_category" &&
                Navigator.of(context).canPop();

            if (condition) {
              Navigator.of(context).pop();
            }
          },
        );
        resetAction();
      },
      failure: (_) => FailureToast.show(context, action),
    );
  }
}
