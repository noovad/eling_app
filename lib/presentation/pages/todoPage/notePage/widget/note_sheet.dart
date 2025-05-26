import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling_app/domain/entities/note/note.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/providers/note_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/widget/note_form.dart';

class NoteSheet extends ConsumerWidget {
  final bool isCreate;
  final NoteEntity? note;

  const NoteSheet({super.key, this.isCreate = false, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(noteProvider.notifier);
    final isValid = ref.watch(noteProvider.select((s) => s.isValid));

    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(child: SingleChildScrollView(child: NoteForm(note: note))),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                AppSpaces.w8,
                ElevatedButton(
                  onPressed:
                      isValid == true
                          ? () {
                            isCreate
                                ? notifier.addNote()
                                : notifier.updateNote(note!.id);

                            Navigator.of(context).pop();
                          }
                          : null,
                  child: Text(isCreate ? 'Create' : 'Update'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
