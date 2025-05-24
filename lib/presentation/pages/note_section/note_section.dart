import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appCard/app_note_card.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:eling_app/presentation/pages/note_section/providers/note_provider.dart';
import 'package:eling_app/presentation/pages/note_section/widget/note_sheet.dart';

class NotePage extends ConsumerWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider.select((s) => s.notes));
    final notifier = ref.read(noteProvider.notifier);

    return Scaffold(
      body: notes.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        failure: (message) {
          return Text(message);
        },
        success: (notes) {
          return Padding(
            padding: AppPadding.all16,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: notes.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Card(
                    elevation: 4,
                    shadowColor: Colors.grey,
                    child: InkWell(
                      onTap:
                          () => {
                            // notifier.clear(),
                            appSheet(
                              side: SheetSide.left,
                              context: context,
                              builder: (_) => NoteSheet(isCreate: true),
                            ),
                          },
                      child: Padding(
                        padding: AppPadding.all12,
                        child: Center(child: Icon(Icons.add, size: 42)),
                      ),
                    ),
                  );
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
      ),
    );
  }
}
