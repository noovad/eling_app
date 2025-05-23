import 'package:eling_app/presentation/pages/note_section/models/content.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/widgets/dropdown/app_dropdown.dart';
import 'package:eling_app/domain/entities/note/note.dart';
import 'package:eling_app/presentation/pages/note_section/providers/note_provider.dart';

class NoteForm extends ConsumerWidget {
  final NoteEntity? note;

  const NoteForm({super.key, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref
        .watch(noteProvider)
        .categories
        .whenOrNull(
          success:
              (data) =>
                  data
                      .map(
                        (e) =>
                            DropdownItem<String>(id: e.name!, label: e.name!),
                      )
                      .toList(),
        );
    final state = ref.watch(noteProvider);
    final notifier = ref.read(noteProvider.notifier);
    return Column(
      spacing: AppSizes.dimen16,
      children: [
        AppTextField(
          initialValue: state.title.value,
          onChanged: (value) => notifier.titleChanged(value),
          label: 'Title',
          hint: 'Enter note title',
          errorText: state.title.displayError?.message,
        ),

        AppDropdown<String>(
          label: 'Category',
          items: categories ?? [],
          selectedItem:
              state.selectedCategory != null
                  ? DropdownItem<String>(
                    id: state.selectedCategory!,
                    label: state.selectedCategory!,
                  )
                  : null,
          onChanged: (item) {
            notifier.categoryChanged(item?.id ?? '');
          },
        ),

        AppTextField(
          initialValue: state.content.value,
          onChanged: (value) => notifier.contentChanged(value),
          minLines: 5,
          maxLines: 10,
          hint: 'Write your note here...',
          label: 'Content',
          errorText: state.content.displayError?.message,
        ),
      ],
    );
  }
}
