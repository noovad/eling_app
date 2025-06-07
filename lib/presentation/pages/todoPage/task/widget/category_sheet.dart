import 'package:eling/core/enum/category_type.dart';
import 'package:eling/core/providers/notifier/task_notifier_provider.dart';
import 'package:eling/core/utils/resource.dart';
import 'package:eling/domain/entities/category/category.dart';
import 'package:eling/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class CategorySheet extends ConsumerStatefulWidget {
  final CategoryType categoryType;

  const CategorySheet({super.key, required this.categoryType});

  @override
  ConsumerState<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends ConsumerState<CategorySheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final categoryTitle = ref.read(taskNotifierProvider).categoryTitle;
    _controller = TextEditingController(text: categoryTitle.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listenToReset() {
    final categoryTitle = ref.watch(
      taskNotifierProvider.select((s) => s.categoryTitle),
    );
    if (categoryTitle.isPure && _controller.text.isNotEmpty) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    _listenToReset();
    final notifier = ref.read(taskNotifierProvider.notifier);
    final isValidCategory = ref.watch(
      taskNotifierProvider.select((s) => s.isValidCategory),
    );

    late final Resource<List<CategoryEntity>> resourceCategories;
    switch (widget.categoryType) {
      case CategoryType.daily:
        resourceCategories = ref.watch(
          taskNotifierProvider.select((s) => s.dailyCategories),
        );
        break;
      case CategoryType.productivity:
        resourceCategories = ref.watch(
          taskNotifierProvider.select((s) => s.productivityCategories),
        );
        break;
      case CategoryType.note:
        resourceCategories = ref.watch(
          taskNotifierProvider.select((s) => s.noteCategories),
        );
        break;
    }

    final categories =
        resourceCategories.whenOrNull(success: (value) => value) ?? [];

    return Padding(
      padding: AppPadding.h16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSizes.dimen16,
        children: [
          AppSpaces.h40,
          AppTextField(
            label: "Title",
            hint: "Enter title",
            controller: _controller,
            onChanged: notifier.categoyrTitleChanged,
            errorText: ref.watch(
              taskNotifierProvider.select(
                (s) => s.categoryTitle.displayError?.message,
              ),
            ),
            isRequired: true,
            maxLines: 1,
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
                    isValidCategory
                        ? () => notifier.saveCategory(widget.categoryType)
                        : null,
                child: Text('Create'),
              ),
            ],
          ),
          AppSpaces.h16,
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
                        ).colorScheme.outline.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    elevation: 4,
                    shadowColor: Theme.of(context).colorScheme.outline,
                    child: ListTile(
                      title: Text(categories[index].name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed:
                            () => notifier.deleteCategory(
                              categories[index].id,
                              widget.categoryType,
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
