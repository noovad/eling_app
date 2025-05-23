import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/widgets/appField/app_date_field.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';
import 'package:flutter_ui/widgets/appField/app_time_field.dart';
import 'package:flutter_ui/widgets/dropdown/app_dropdown.dart';

class TaskForm extends StatefulWidget {
  final TaskTabsType todoTabsType;
  final TaskType? taskType;
  final bool status;

  const TaskForm({
    super.key,
    required this.todoTabsType,
    this.taskType,
    this.status = false,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSizes.dimen24,
        children: [
          AppTextField(
            label: "Title",
            hint: "Enter title",
            enabled: !widget.status,
            onChanged: (yow) {},
          ),
          AppDropdown(
            items: [],
            label: "Category",
            hint: "Select category",
            enable: !widget.status,

            // selectedItem:
            //     widget.categoryController.text.isNotEmpty
            //         ? DropdownItem<String>(
            //           id: widget.categoryController.text,
            //           label: widget.categoryController.text,
            //         )
            //         : null,
            onChanged: (value) {},
          ),
          AppTimeField(controller: TextEditingController()),
          AppDateField(controller: TextEditingController()),
          AppTextField(
            label: "Notes",
            hint: "Enter notes",
            maxLines: 5,
            minLines: 3,
            enabled: !widget.status,
            onChanged: (yow) {},
          ),
        ],
      ),
    );
  }
}
