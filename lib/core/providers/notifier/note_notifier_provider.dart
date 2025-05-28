import 'package:eling_app/core/providers/usecase/category/getCategories/get_categories_provider.dart';
import 'package:eling_app/core/providers/usecase/note/getNotes/get_notes_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/notifier/note_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteNotifierProvider = StateNotifierProvider<NoteNotifier, NoteState>((
  ref,
) {
  return NoteNotifier(
    ref.watch(getNotesUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider),
  );
});
