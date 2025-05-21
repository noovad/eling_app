import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_provider.dart';
import 'package:my_app/presentation/pages/note_section/widget/note_form.dart';

class NoteSheet extends ConsumerStatefulWidget {
  final bool isCreate;
  const NoteSheet({super.key, this.isCreate = false});

  @override
  ConsumerState<NoteSheet> createState() => _NoteSheetState();
}

class _NoteSheetState extends ConsumerState<NoteSheet> {
  @override
  void initState() {
    super.initState();
  }

  void _handleSave() {
    final notifier = ref.read(noteProvider.notifier);

    if (widget.isCreate) {
      notifier.addNote();
    } else {
      // notifier.updateNote(state.selectedNote?.id ?? '');
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(child: SingleChildScrollView(child: NoteForm())),
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
          onPressed: _handleSave,
          child: Text(widget.isCreate ? 'Create' : 'Update'),

        ),
      ],
    );
  }
}
