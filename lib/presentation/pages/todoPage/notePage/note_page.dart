import 'package:eling_app/core/providers/notifier/note_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appCard/app_note_card.dart';
import 'package:flutter_ui/widgets/appCard/app_note_shimmer_card.dart';
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

    return notes.when(
      initial: () => _buildShimmerGrid(context),
      loading: () => _buildShimmerGrid(context),
      failure: (message) {
        return Text(message);
      },
      success: (notes) {
        return Padding(
          padding: AppPadding.all16,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: notes.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      notifier.fetchNoteCategories();
                      appSheet(
                        side: SheetSide.left,
                        context: context,
                        builder: (_) => const NoteSheet(isCreate: true),
                      );
                    },
                    child: const Padding(
                      padding: AppPadding.all12,
                      child: Center(child: Icon(Icons.add, size: 42)),
                    ),
                  ),
                );
              }
              final note = notes[index - 1];
              return AppNoteCard(
                noteTitle: note.title,
                noteContent: note.content,
                noteCategory: note.category,
                noteId: note.id,
                showIsPinned: showIsPinned,
                isPinned: note.isPinned ?? false,
                onDelete: (value) => notifier.deleteNote(note.id),
                onUpdate: (value) {
                  notifier.updatePinned(note.id, note.isPinned ?? false);
                },
                onTap: () {
                  notifier.set(note);
                  notifier.fetchNoteCategories();
                  appSheet(
                    side: SheetSide.left,
                    context: context,
                    builder: (_) => NoteSheet(note: note),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildShimmerGrid(BuildContext context) {
    return Padding(
      padding: AppPadding.all16,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 12, // Create card + 5 shimmer notes
        itemBuilder: (context, index) {
          if (index == 0) {
            return Card(
              child: InkWell(
                onTap:
                    () => {
                      appSheet(
                        side: SheetSide.left,
                        context: context,
                        builder: (_) => const NoteSheet(isCreate: true),
                      ),
                    },
                child: const Padding(
                  padding: AppPadding.all12,
                  child: Center(child: Icon(Icons.add, size: 42)),
                ),
              ),
            );
          }
          return const AppNoteShimmerCard();
        },
      ),
    );
  }
}
