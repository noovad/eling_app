import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appCard/todo_card.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_section.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_sheet.dart';

class TodoListData extends StatelessWidget {
  const TodoListData({super.key});

  @override
  Widget build(BuildContext context) {
    Widget appCard({required Widget child, Color? color, double? height}) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Card(
          elevation: 4,
          shadowColor: Colors.grey,
          color: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: child,
        ),
      );
    }

    return Expanded(
      child: Column(
        spacing: 12,
        children: [
          Padding(
            padding: AppPadding.h12,
            child: appCard(
              height: 50,
              child: InkWell(
                onTap:
                    () => appSheet(
                      side: SheetSide.right,
                      context: context,
                      builder:
                          (context) => TodoSheet.create(
                            taskType: TaskType.daily,
                            tabsType: TabsType.today,
                          ),
                    ),
                child: const Padding(
                  padding: AppPadding.h8,
                  child: Icon(Icons.add, size: 24),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 172,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: AppPadding.h12,
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TodoCard(
                    title: "Todo Title",
                    category: "Category",
                    time: "12:00 PM",
                    isDone: false,
                    id: "1",
                    onUpdateStatus: (fd) {},
                    onDelete: (fd) {},
                    leading: true,
                    ontap:
                        () => appSheet(
                          context: context,
                          side: SheetSide.right,
                          builder:
                              (context) => TodoSheet.update(
                                tabsType: TabsType.today,

                                taskType: TaskType.daily,
                              ),
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
