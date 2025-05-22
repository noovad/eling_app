import 'package:flutter/material.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_list_data.dart';


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
