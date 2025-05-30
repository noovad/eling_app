import 'package:eling_app/core/providers/usecase/category/getCategories/get_categories_provider.dart';
import 'package:eling_app/core/providers/usecase/note/createNote/create_note_provider.dart';
import 'package:eling_app/core/providers/usecase/note/deleteNote/delete_note_provider.dart';
import 'package:eling_app/core/providers/usecase/note/getNotes/get_notes_provider.dart';
import 'package:eling_app/core/providers/usecase/note/updateNote/update_note_provider.dart';
import 'package:eling_app/core/providers/usecase/note/updatePinnedNote/update_pinned_note_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/notifier/note_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteNotifierProvider = StateNotifierProvider<NoteNotifier, NoteState>((
  ref,
) {
  return NoteNotifier(
    ref.watch(getNotesUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider),
    ref.watch(createNoteUseCaseProvider),
    ref.watch(updateNoteUseCaseProvider),
    ref.watch(updatePinnedNoteUseCaseProvider),
    ref.watch(deleteNoteUseCaseProvider),
  );
});
