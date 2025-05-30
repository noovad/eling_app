import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/presentation/widgets/failure_toast.dart';
import 'package:eling_app/presentation/widgets/success_toast.dart';
import 'package:flutter/material.dart';

class ResultHandler {
  static void handleResult({
    required BuildContext context,
    required Resource<String> result,
    required SuccessAction successAction,
    required VoidCallback resetAction,
    FailureAction failureAction = FailureAction.save,
  }) {
    result.whenOrNull(
      success: (_) {
        SuccessToast.show(context, successAction);
        resetAction();
        result.whenOrNull(
          success: (value) {
            if (value != "category" && Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        );
      },
      failure: (errorMessage) => FailureToast.show(context, failureAction),
    );
  }
}
