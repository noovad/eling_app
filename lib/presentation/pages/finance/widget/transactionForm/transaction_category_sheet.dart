import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class TransactionCategorySheet extends ConsumerStatefulWidget {
  const TransactionCategorySheet({super.key});

  @override
  ConsumerState<TransactionCategorySheet> createState() =>
      _TransactionCategorySheetState();
}

class _TransactionCategorySheetState
    extends ConsumerState<TransactionCategorySheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listenToReset() {
    final categoryName = ref.watch(
      financeNotifierProvider.select((s) => s.categoryName),
    );
    if (categoryName.isPure && _controller.text.isNotEmpty) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    _listenToReset();
    final isFormValid = ref.watch(
      financeNotifierProvider.select((s) => s.isCategoryFormValid),
    );
    final name = ref.watch(
      financeNotifierProvider.select((s) => s.categoryName),
    );
    final categories = ref.watch(
      financeNotifierProvider.select((s) => s.transactionCategories),
    );

    final data =
        categories.whenOrNull(success: (categories) => categories) ?? [];
    final notifier = ref.read(financeNotifierProvider.notifier);

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
            onChanged: notifier.categoryNameChanged,
            maxLines: 1,
            errorText: name.displayError?.message,
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
                onPressed:
                    isFormValid
                        ? () => notifier.createTransactionCategory(name.value)
                        : null,
                child: const Text('Create'),
              ),
            ],
          ),
          AppSpaces.h16,
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = data[index];
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
                          notifier.deleteTransactionCategory(category.id);
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
