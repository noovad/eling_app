import 'package:eling_app/presentation/pages/todoPage/notePage/note_page.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/summary_page.dart';
import 'package:eling_app/core/providers/notifier/task_notifier_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/task/task_page.dart';
import 'package:eling_app/presentation/utils/result_handler.dart';
import 'package:eling_app/presentation/widgets/success_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskNotifierProvider.notifier);

    ref.listen(
      taskNotifierProvider.select((state) => state.saveResult),
      (previous, current) => ResultHandler.handleResult(
        context: context,
        result: current,
        successAction: SuccessAction.save,
        resetAction: notifier.resetIsSaving,
      ),
    );

    ref.listen(
      taskNotifierProvider.select((state) => state.updateResult),
      (previous, current) => ResultHandler.handleResult(
        context: context,
        result: current,
        successAction: SuccessAction.update,
        resetAction: notifier.resetIsUpdate,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double taskWidth = screenWidth - 700;
          if (taskWidth < 700) taskWidth = 700;
          double totalContentWidth = taskWidth + 700;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: totalContentWidth),
              child: Row(
                children: [
                  SizedBox(width: taskWidth, child: TaskPage()),
                  Container(
                    color: Colors.white,
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SummaryPage(),
                        Expanded(child: NotePage()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
