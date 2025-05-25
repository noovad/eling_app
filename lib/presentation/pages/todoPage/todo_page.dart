import 'package:eling_app/presentation/pages/todoPage/note_section/note_section.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/summary_page.dart';
import 'package:eling_app/presentation/pages/todoPage/task/task_page.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: TaskPage()),
          SizedBox(
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
