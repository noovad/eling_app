import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appCard/app_note_card.dart';
import 'package:flutter_ui/widgets/appCard/app_note_shimmer_card.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/providers/note_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/widget/note_sheet.dart';

class NotePage extends ConsumerWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider.select((s) => s.notes));
    final notifier = ref.read(noteProvider.notifier);

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
                return _buildCreateCard(context);
              }
              final note = notes[index - 1];
              return AppNoteCard(
                noteTitle: note.title ?? "",
                noteContent: note.content ?? "",
                noteCategory: note.category ?? "",
                noteId: note.id ?? "",
                isPinned: note.isPinned ?? false,
                onDelete: (value) => notifier.deleteNote(value),
                onUpdate: (value) => notifier.togglePin(value),
                onTap: () {
                  notifier.set(note);
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
            return _buildCreateCard(context);
          }
          return const AppNoteShimmerCard();
        },
      ),
    );
  }

  Widget _buildCreateCard(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey,
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
}
