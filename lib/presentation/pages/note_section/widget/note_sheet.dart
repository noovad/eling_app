import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:my_app/domain/entities/note/note.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_provider.dart';
import 'package:my_app/presentation/pages/note_section/widget/note_form.dart';

class NoteSheet extends ConsumerStatefulWidget {
  final bool isCreate;
  final NoteEntity? note;

  const NoteSheet({super.key, this.isCreate = false, this.note});

  @override
  ConsumerState<NoteSheet> createState() => _NoteSheetState();
}

class _NoteSheetState extends ConsumerState<NoteSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(child: NoteForm(note: widget.note)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: buttonSection(context),
          ),
        ],
      ),
    );
  }

  Row buttonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        AppSpaces.w8,
        ElevatedButton(
          onPressed: () {
            final notifier = ref.read(noteProvider.notifier);
            if (widget.isCreate) {
              notifier.addNote();
            } else {
              notifier.updateNote(widget.note!.id ?? '');
            }
            Navigator.of(context).pop();
          },
          child: Text(widget.isCreate ? 'Create' : 'Update'),
        ),
      ],
    );
  }
}
