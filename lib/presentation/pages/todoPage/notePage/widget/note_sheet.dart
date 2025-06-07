import 'package:eling/core/providers/notifier/note_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling/domain/entities/note/note.dart';
import 'package:eling/presentation/pages/todoPage/notePage/widget/note_form.dart';

class NoteSheet extends ConsumerStatefulWidget {
  final bool isCreate;
  final NoteEntity? note;

  const NoteSheet({super.key, this.isCreate = false, this.note});

  @override
  ConsumerState<NoteSheet> createState() => _NoteSheetState();
}

class _NoteSheetState extends ConsumerState<NoteSheet> {
  late bool isEditMode;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.isCreate;
  }

  String get title {
    if (widget.isCreate) return 'Create Note';
    return isEditMode ? 'Update Note' : 'Note Detail';
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(noteNotifierProvider.notifier);
    final isValid = ref.watch(noteNotifierProvider.select((s) => s.isValid));

    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: !widget.isCreate,
                replacement: AppSpaces.w48,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode;
                    });
                  },
                  icon: Icon(
                    isEditMode
                        ? Icons.visibility_outlined
                        : Icons.edit_note_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  tooltip: isEditMode ? 'Cancel Edit' : 'Edit Note',
                ),
              ),

              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              AppSpaces.w48,
            ],
          ),
          AppSpaces.h20,
          Flexible(
            child: SingleChildScrollView(
              child: NoteForm(
                note: widget.note,
                readOnly: !widget.isCreate && !isEditMode,
              ),
            ),
          ),
          AppSpaces.h40,

          Visibility(
            visible: widget.isCreate || isEditMode,
            replacement: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!widget.isCreate && isEditMode) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cancel'),
                ),
                AppSpaces.w8,
                ElevatedButton(
                  onPressed:
                      isValid == true
                          ? () {
                            if (widget.isCreate) {
                              notifier.createNote();
                            } else {
                              notifier.updateNote(widget.note!);
                              setState(() {
                                isEditMode = false;
                              });
                            }
                          }
                          : null,
                  child: Text(widget.isCreate ? 'Create' : 'Update'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
