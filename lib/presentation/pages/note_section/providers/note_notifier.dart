import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/utils/resource.dart';
import 'package:my_app/domain/entities/note.dart';
import 'package:my_app/domain/usecases/base_usecase.dart';
import 'package:my_app/domain/usecases/note/get_notes.dart';
import 'package:my_app/presentation/pages/note_section/models/content.dart';
import 'package:my_app/presentation/pages/note_section/models/title.dart';

part 'note_state.dart';
part 'note_notifier.freezed.dart';

class NoteNotifier extends StateNotifier<NoteState> {
  final GetNotesUseCase getNotesUseCase;

  NoteNotifier(this.getNotesUseCase) : super(NoteState.initial()) {
    fetchNotes();
    fetchCategories();
  }

  void fetchNotes() async {
    final result = await getNotesUseCase.execute(NoRequest());

    result.when(
      success: (data) {
        state = state.copyWith(notes: Resource.success(data));
      },
      failure: (message) {
        state = state.copyWith(notes: Resource.failure(message));
      },
    );
  }

  void fetchCategories() async {
    // Simulate fetching categories
    final categories = ['Work', 'Personal', 'Urgent'];
    state = state.copyWith(categories: Resource.success(categories));
  }

  void addNote() {
    final title = TitleInput.dirty(value: state.title.value);
    final content = ContentInput.dirty(value: state.content.value);
    final selectedCategory = state.selectedCategory;
    final isValid = Formz.validate([title, content]);

    if (!isValid) {
      state = state.copyWith(title: title, content: content, isValid: false);
      return;
    }

    final newNote = NoteEntity(
      title: title.value,
      content: content.value,
      category: selectedCategory ?? '',
      isPinned: false,
    );

    debugPrint('add note $newNote');
  }

  void updateNote(String id) {
    debugPrint('update note');
  }

  void togglePin(String id) {
    debugPrint('pin note');
  }

  void deleteNote(String id) {
    debugPrint('delete note');
  }

  void titleChanged(String value) {
    final title = TitleInput.dirty(value: value);
    final isValid = Formz.validate([title, state.content]);
    state = state.copyWith(title: title, isValid: isValid);
  }

  void contentChanged(String value) {
    final content = ContentInput.dirty(value: value);
    final isValid = Formz.validate([state.title, content]);
    state = state.copyWith(content: content, isValid: isValid);
  }

  void categoryChanged(String value) {
    state = state.copyWith(selectedCategory: value);
  }
}
