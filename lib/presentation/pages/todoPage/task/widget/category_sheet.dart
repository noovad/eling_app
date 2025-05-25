// ignore_for_file: deprecated_member_use

import 'package:eling_app/core/enum/category_type.dart';
import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/category/category.dart';
import 'package:eling_app/presentation/pages/todoPage/task/provider/task_provider.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class CategorySheet extends ConsumerWidget {
  final CategoryType? categoryType;

  const CategorySheet({super.key, required this.categoryType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskProvider.notifier);
    final isValidCategory = ref.watch(
      taskProvider.select((state) => state.isValidCategory),
    );
    final titleCategory = ref.watch(
      taskProvider.select((s) => s.categoryTitle),
    );

    late final Resource<List<CategoryEntity>> resourceCategories;
    switch (categoryType) {
      case CategoryType.daily:
        resourceCategories = ref.watch(
          taskProvider.select((s) => s.dailyCategories),
        );
        break;
      case CategoryType.productivity:
        resourceCategories = ref.watch(
          taskProvider.select((s) => s.productivityCategories),
        );
        break;
      case CategoryType.note:
        resourceCategories = ref.watch(
          taskProvider.select((s) => s.noteCategories),
        );
        break;
      case null:
    }

    final categories =
        resourceCategories.whenOrNull(success: (value) => value) ?? [];

    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSizes.dimen16,
        children: [
          AppTextField(
            label: "Title",
            hint: "Enter title",
            onChanged: (value) => notifier.categoyrTitleChanged(value),
            errorText: titleCategory.displayError?.message,
            // initialValue: title.value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              AppSpaces.w8,
              ElevatedButton(
                onPressed:
                    isValidCategory ? () => notifier.saveCategory() : null,
                child: Text('Create'),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(top: AppSizes.dimen16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                    elevation: 4,
                    shadowColor: Theme.of(context).colorScheme.outline,
                    child: ListTile(
                      title: Text(categories[index].name ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed:
                            () => notifier.deleteCategory(
                              categories[index].name ?? '',
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
