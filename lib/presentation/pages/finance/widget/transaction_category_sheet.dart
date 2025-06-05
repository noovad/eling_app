import 'package:eling_app/domain/entities/transaction_category/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class TransactionCategorySheet extends StatefulWidget {
  final Function(String name)? onCategoryCreate;
  final Function(String id)? onCategoryDelete;
  final List<TransactionCategoryEntity>? categories;
  const TransactionCategorySheet({
    super.key,
    this.onCategoryCreate,
    this.onCategoryDelete,
    this.categories,
  });

  @override
  State<TransactionCategorySheet> createState() =>
      _TransactionCategorySheetState();
}

class _TransactionCategorySheetState extends State<TransactionCategorySheet> {
  final TextEditingController _controller = TextEditingController();
  late List<TransactionCategoryEntity> _categories;

  @override
  void initState() {
    super.initState();
    _categories = List<TransactionCategoryEntity>.from(widget.categories ?? []);
  }

  void _createCategory() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    setState(() {
      final newCategory = TransactionCategoryEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
      );
      _categories.add(newCategory);
    });
    widget.onCategoryCreate?.call(name);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Category created successfully'),
        duration: Duration(seconds: 2),
      ),
    );
    _controller.clear();
  }

  void _deleteCategory(TransactionCategoryEntity category) {
    setState(() {
      _categories.removeWhere((c) => c.id == category.id);
    });
    widget.onCategoryDelete?.call(category.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${category.name} deleted'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.h16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpaces.h40,
          AppTextField(
            controller: _controller,
            label: "Category Name",
            hint: "Enter category name",
            isRequired: true,
          ),
          AppSpaces.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              AppSpaces.w8,
              ElevatedButton(
                onPressed: _createCategory,
                child: const Text('Create'),
              ),
            ],
          ),
          AppSpaces.h16,
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: _categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Card(
                    margin: EdgeInsets.only(top: AppSizes.dimen16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withAlpha(64),
                        width: 1,
                      ),
                    ),
                    elevation: 4,
                    shadowColor: Theme.of(context).colorScheme.outline,
                    child: ListTile(
                      title: Text(category.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('Delete Category'),
                                  content: Text(
                                    'Are you sure you want to delete ${category.name}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _deleteCategory(category);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                          );
                        },
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
