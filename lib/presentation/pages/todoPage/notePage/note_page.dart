import 'package:eling_app/core/providers/notifier/note_notifier_provider.dart';
import 'package:eling_app/presentation/utils/result_handler.dart';
import 'package:eling_app/presentation/widgets/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appCard/app_note_card.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/widget/note_sheet.dart';

class NotePage extends ConsumerWidget {
  const NotePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteNotifierProvider.select((s) => s.notes));
    final notifier = ref.read(noteNotifierProvider.notifier);
    final countPinnedNotes = ref.watch(
      noteNotifierProvider.select((s) => s.countPinnedNotes),
    );
    final maxPinned = 5;
    final pinnedNotesCount = countPinnedNotes.maybeWhen(
      success: (count) => count,
      orElse: () => 0,
    );
    final showIsPinned = pinnedNotesCount < maxPinned;

    ref.listen(
      noteNotifierProvider.select((state) => state.saveResult),
      (previous, current) => ResultHandler.handleResult(
        context: context,
        result: current,
        action: ForAction.save,
        resetAction: notifier.resetIsSaving,
      ),
    );

    ref.listen(
      noteNotifierProvider.select((state) => state.updateResult),
      (previous, current) => ResultHandler.handleResult(
        context: context,
        result: current,
        action: ForAction.update,
        resetAction: notifier.resetIsUpdate,
      ),
    );

    ref.listen(
      noteNotifierProvider.select((state) => state.deleteResult),
      (previous, current) => ResultHandler.handleResult(
        context: context,
        result: current,
        action: ForAction.delete,
        resetAction: notifier.resetIsDelete,
      ),
    );

    return Padding(
      padding: AppPadding.all16,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Card(
              child: InkWell(
                onTap: () {
                  notifier.clear();
                  appSheet(
                    side: SheetSide.left,
                    context: context,
                    builder: (_) => const NoteSheet(isCreate: true),
                  );
                },
                child: Padding(
                  padding: AppPadding.h8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 24),
                      AppSpaces.w4,
                      Text(
                        'Note',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AppSpaces.h16,
          Expanded(
            child: notes.maybeWhen(
              success: (notes) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return AppNoteCard(
                      noteTitle: note.title,
                      noteContent: note.content,
                      noteCategory: note.category,
                      noteId: note.id,
                      showIsPinned: showIsPinned,
                      isPinned: note.isPinned ?? false,
                      onDelete: (value) {
                        deleteDialog(context, () {
                          notifier.deleteNote(note.id);
                        });
                      },
                      onUpdate: (value) {
                        notifier.updatePinned(note.id, note.isPinned ?? false);
                      },
                      onTap: () {
                        notifier.set(note);
                        notifier.getNoteCategories();
                        appSheet(
                          side: SheetSide.left,
                          context: context,
                          builder: (_) => NoteSheet(note: note),
                        );
                      },
                    );
                  },
                );
              },
              failure: (msg) => Center(child: Text(msg)),
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
