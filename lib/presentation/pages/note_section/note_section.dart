import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appCard/note_card.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';
import 'package:my_app/presentation/pages/note_section/models/content.dart';
import 'package:my_app/presentation/pages/note_section/models/title.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_provider.dart';

class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key});

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteProvider);
    final notifier = ref.read(noteProvider.notifier);

    if (titleController.text != state.title.value) {
      titleController.text = state.title.value;
      titleController.selection = TextSelection.fromPosition(TextPosition(offset: titleController.text.length));
    }
    if (contentController.text != state.content.value) {
      contentController.text = state.content.value;
      contentController.selection = TextSelection.fromPosition(TextPosition(offset: contentController.text.length));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(
              controller: titleController,
              label: "Title",
              hint: "Enter title",
              onChanged: (value) => notifier.titleChanged(value),
              errorText: state.title.error?.getMessage(),
            ),
            AppTextField(
              controller: contentController,
              label: "Content",
              hint: "Enter content",
              onChanged: (value) => notifier.contentChanged(value),
              errorText: state.content.error?.getMessage(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed:
                  state.isValid
                      ? () {
                        notifier.addNote();
                        titleController.clear();
                        contentController.clear();
                      }
                      : null,
              child: const Text('Save'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: state.notes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return NoteCard(
                    note: note,
                    onTap: () {
                      debugPrint('Tapped note id: ${note.id}');
                      notifier.togglePin(note.id!);
                    },
                    onUpdate: (updatedNote) {
                      notifier.updateNote(updatedNote);
                    },
                    onDelete: (deletedNote) {
                      notifier.deleteNote(deletedNote.id!);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
