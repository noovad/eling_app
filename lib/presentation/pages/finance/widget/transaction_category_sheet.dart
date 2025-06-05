import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class TransactionCategorySheet extends StatelessWidget {
  const TransactionCategorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for categories
    final List<CategoryItem> categories = [
      CategoryItem(id: '1', name: 'Food & Dining'),
      CategoryItem(id: '2', name: 'Transportation'),
      CategoryItem(id: '3', name: 'Shopping'),
      CategoryItem(id: '4', name: 'Entertainment'),
      CategoryItem(id: '5', name: 'Utilities'),
      CategoryItem(id: '6', name: 'Healthcare'),
      CategoryItem(id: '7', name: 'Education'),
      CategoryItem(id: '8', name: 'Travel'),
    ];

    return Padding(
      padding: AppPadding.h16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpaces.h40,
          AppTextField(
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
                onPressed: () {
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category created successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Create'),
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
                  final category = categories[index];
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
                      title: Text(category.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          // Show delete confirmation
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
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${category.name} deleted',
                                            ),
                                            duration: const Duration(
                                              seconds: 2,
                                            ),
                                          ),
                                        );
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

// Simple data class for category
class CategoryItem {
  final String id;
  final String name;

  CategoryItem({required this.id, required this.name});
}
