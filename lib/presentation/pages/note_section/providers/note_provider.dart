import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:my_app/domain/usecases/category/getCategories/get_categories.dart';
import 'package:my_app/domain/usecases/note/getNotes/get_notes.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_notifier.dart';

final getNotesUseCaseProvider = Provider<GetNotesUseCase>((ref) {
  return GetNotesUseCaseImpl(logger: Logger());
});

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  return GetCategoriesUseCaseImpl(logger: Logger());
});

final noteProvider = StateNotifierProvider<NoteNotifier, NoteState>((ref) {
  return NoteNotifier(ref.watch(getNotesUseCaseProvider), ref.watch(getCategoriesUseCaseProvider));
});
