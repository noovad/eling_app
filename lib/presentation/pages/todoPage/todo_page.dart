import 'package:eling_app/presentation/pages/todoPage/notePage/note_page.dart';
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
