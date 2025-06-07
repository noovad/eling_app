import 'package:eling/core/providers/notifier/note_notifier_provider.dart';
import 'package:eling/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eling/domain/entities/note/note.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class NoteForm extends ConsumerWidget {
  final NoteEntity? note;
  final bool readOnly;

  const NoteForm({super.key, this.note, this.readOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref
        .watch(noteNotifierProvider)
        .categories
        .whenOrNull(
          success:
              (data) =>
                  data
                      .map(
                        (e) => DropdownItem<String>(id: e.name, label: e.name),
                      )
                      .toList(),
        );
    final state = ref.watch(noteNotifierProvider);
    final notifier = ref.read(noteNotifierProvider.notifier);
    return Column(
      children: [
        AppTextField(
          initialValue: state.title.value,
          onChanged: notifier.titleChanged,
          label: 'Title',
          hint: 'Enter note title',
          errorText: state.title.displayError?.message,
          isRequired: true,
          maxLines: 1,
          readOnly: readOnly,
        ),
        AppSpaces.h24,
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
          onChanged:
              readOnly
                  ? null
                  : (item) {
                    notifier.categoryChanged(item?.id ?? '');
                  },
        ),
        AppSpaces.h24,
        AppTextField(
          initialValue: state.content.value,
          onChanged: notifier.contentChanged,
          minLines: 5,
          maxLines: 30,
          hint: 'Write your note here...',
          label: 'Content',
          errorText: state.content.displayError?.message,
          isRequired: true,
          readOnly: readOnly,
        ),
      ],
    );
  }
}
