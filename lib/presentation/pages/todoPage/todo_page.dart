import 'package:eling_app/presentation/pages/todoPage/notePage/note_page.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/summary_page.dart';
import 'package:eling_app/presentation/pages/todoPage/task/task_page.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: const [
                        SummaryPage(),
                        Divider(thickness: 2, indent: 12, endIndent: 12),
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
