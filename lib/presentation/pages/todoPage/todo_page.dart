import 'package:eling_app/presentation/pages/todoPage/notePage/note_page.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/summary_page.dart';
import 'package:eling_app/presentation/pages/todoPage/task/provider/task_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/task/task_page.dart';
import 'package:eling_app/presentation/widgets/failure_toast.dart';
import 'package:eling_app/presentation/widgets/success_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(taskProvider.select((state) => state.isSaving), (
      previous,
      current,
    ) {
      current.whenOrNull(
        success: (isSuccess) {
          SuccessToast.show(context, SuccessAction.save);
          Navigator.of(context).pop();
        },
        failure: (message) => {FailureToast.show(context, FailureAction.save)},
      );
    });

    return Scaffold(
      body: Row(
        children: [
          Expanded(child: TaskPage()),
          Container(
            color: Colors.white,
            width: 700,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [SummaryPage(), Expanded(child: NotePage())],
            ),
          ),
        ],
      ),
    );
  }
}
