import 'package:flutter/material.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_list_data.dart';

enum TabsType { today, upcoming, history, auto }

class TodoSection extends StatelessWidget {
  const TodoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [TodoListData(), TodoListData()],
    );
  }
}
