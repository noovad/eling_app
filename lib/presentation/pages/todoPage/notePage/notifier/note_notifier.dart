import 'package:eling/domain/usecases/note/countPinnedNotes/count_pinned_notes.dart';
import 'package:eling/domain/usecases/note/createNote/create_note.dart';
import 'package:eling/domain/usecases/note/createNote/create_note_request.dart';
import 'package:eling/domain/usecases/note/deleteNote/delete_note.dart';
import 'package:eling/domain/usecases/note/deleteNote/delete_note_request.dart';
import 'package:eling/domain/usecases/note/updateNote/update_note.dart';
import 'package:eling/domain/usecases/note/updateNote/update_note_request.dart';
import 'package:eling/domain/usecases/note/updatePinnedNote/update_pinned_note.dart';
import 'package:eling/domain/usecases/note/updatePinnedNote/update_pinned_note_request.dart';
import 'package:eling/presentation/pages/todoPage/notePage/models/content.dart';
import 'package:eling/presentation/pages/todoPage/notePage/models/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling/core/enum/category_type.dart';
import 'package:eling/core/utils/resource.dart';
import 'package:eling/domain/entities/category/category.dart';
import 'package:eling/domain/entities/note/note.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/category/getCategories/get_categories.dart';
import 'package:eling/domain/usecases/category/getCategories/get_categories_request.dart';
import 'package:eling/domain/usecases/note/getNotes/get_notes.dart';
import 'package:uuid/uuid.dart';

part 'note_state.dart';
part 'note_notifier.freezed.dart';

class NoteNotifier extends StateNotifier<NoteState> {
  final GetNotesUseCase getNotesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final CreateNoteUseCase createNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final UpdatePinnedNoteUseCase updatePinnedNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final CountPinnedNotesUseCase countPinnedNotesUseCase;

  NoteNotifier(
    this.getNotesUseCase,
    this.getCategoriesUseCase,
    this.createNoteUseCase,
    this.updateNoteUseCase,
    this.updatePinnedNoteUseCase,
    this.deleteNoteUseCase,
    this.countPinnedNotesUseCase,
  ) : super(NoteState.initial()) {
    getNotes();
    countPinnedNotes();
    getNoteCategories();
  }

  void getNotes() async {
    final result = await getNotesUseCase.execute(NoRequest());

    result.when(
      success: (data) {
        state = state.copyWith(notes: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(notes: Resource.failure(error));
      },
    );
  }

  void getNoteCategories() async {
    final result = await getCategoriesUseCase.execute(
      GetCategoriesRequest(categoryType: CategoryType.note),
    );
    result.when(
      success: (data) {
        state = state.copyWith(categories: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(categories: Resource.failure(error));
      },
    );
  }

  void createNote() async {
    final note = NoteEntity(
      id: const Uuid().v4(),
      title: state.title.value,
      content: state.content.value,
      category: state.selectedCategory ?? '',
      isPinned: false,
      createdAt: DateTime.now(),
    );

    final result = await createNoteUseCase.execute(
      CreateNoteRequest(note: note),
    );

    result.when(
      success: (_) {
        getNotes();
        clear();
        state = state.copyWith(saveResult: Resource.success('note'));
      },
      failure: (_) {
        state = state.copyWith(saveResult: Resource.failure('note'));
      },
    );
  }

  void updateNote(NoteEntity task) async {
    final data = NoteEntity(
      id: task.id,
      title: state.title.value,
      content: state.content.value,
      category: state.selectedCategory ?? '',
      isPinned: task.isPinned,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
    );

    final result = await updateNoteUseCase.execute(
      UpdateNoteRequest(note: data),
    );

    result.when(
      success: (_) {
        getNotes();
        state = state.copyWith(updateResult: Resource.success('note'));
      },
      failure: (_) {
        state = state.copyWith(updateResult: Resource.failure('note'));
      },
    );
  }

  void updatePinned(String id, bool isPinned) async {
    final result = await updatePinnedNoteUseCase.execute(
      UpdatePinnedNoteRequest(id: id, isPinned: isPinned),
    );

    result.when(
      success: (_) {
        getNotes();
        countPinnedNotes();
      },
      failure: (_) {
        state = state.copyWith(saveResult: Resource.failure('pinned'));
      },
    );
  }

  void deleteNote(String id) async {
    final result = await deleteNoteUseCase.execute(DeleteNoteRequest(id: id));

    result.when(
      success: (_) {
        getNotes();
        state = state.copyWith(deleteResult: Resource.success('note'));
      },
      failure: (_) {
        state = state.copyWith(deleteResult: Resource.failure('note'));
      },
    );
  }

  void countPinnedNotes() async {
    final result = await countPinnedNotesUseCase.execute(NoRequest());

    result.when(
      success: (data) {
        state = state.copyWith(countPinnedNotes: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(countPinnedNotes: Resource.failure(error));
      },
    );
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

  void clear() {
    state = state.copyWith(
      title: TitleInput.pure(),
      content: ContentInput.pure(),
      selectedCategory: null,
      isValid: false,
    );
  }

  void set(NoteEntity note) {
    final title = TitleInput.dirty(value: note.title);
    final content = ContentInput.dirty(value: note.content);
    final isValid = Formz.validate([title, content]);

    state = state.copyWith(
      title: title,
      content: content,
      selectedCategory: note.category,
      isValid: isValid,
    );
  }

  void resetIsSaving() {
    state = state.copyWith(saveResult: Resource.initial());
  }

  void resetIsUpdate() {
    state = state.copyWith(updateResult: Resource.initial());
  }

  void resetIsDelete() {
    state = state.copyWith(deleteResult: Resource.initial());
  }
}
