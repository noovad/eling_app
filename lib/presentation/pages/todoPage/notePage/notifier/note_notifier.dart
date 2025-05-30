import 'package:eling_app/domain/usecases/note/countPinnedNotes/count_pinned_notes.dart';
import 'package:eling_app/domain/usecases/note/createNote/create_note.dart';
import 'package:eling_app/domain/usecases/note/createNote/create_note_request.dart';
import 'package:eling_app/domain/usecases/note/deleteNote/delete_note.dart';
import 'package:eling_app/domain/usecases/note/deleteNote/delete_note_request.dart';
import 'package:eling_app/domain/usecases/note/updateNote/update_note.dart';
import 'package:eling_app/domain/usecases/note/updateNote/update_note_request.dart';
import 'package:eling_app/domain/usecases/note/updatePinnedNote/update_pinned_note.dart';
import 'package:eling_app/domain/usecases/note/updatePinnedNote/update_pinned_note_request.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/models/content.dart';
import 'package:eling_app/presentation/pages/todoPage/notePage/models/title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/enum/category_type.dart';
import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/category/category.dart';
import 'package:eling_app/domain/entities/note/note.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories_request.dart';
import 'package:eling_app/domain/usecases/note/getNotes/get_notes.dart';
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
    fetchNotes();
    countPinnedNotes();
  }

  void fetchNotes() async {
    state = state.copyWith(notes: Resource.loading());
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

  void fetchNoteCategories() async {
    final result = await getCategoriesUseCase.execute(
      GetCategoriesRequest(categoryType: CategoryType.note),
    );
    result.when(
      success: (data) {
        state = state.copyWith(categories: Resource.success(data));
      },
      failure: (message) {
        state = state.copyWith(categories: Resource.failure(message));
      },
    );
  }

  void addNote() async {
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
      success: (data) {
        fetchNotes();
        clear();
        state = state.copyWith(saveResult: Resource.success('note'));
      },
      failure: (error) {
        state = state.copyWith(saveResult: Resource.failure(error));
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
      success: (data) {
        fetchNotes();
        state = state.copyWith(saveResult: Resource.success('note'));
      },
      failure: (error) {
        state = state.copyWith(saveResult: Resource.failure(error));
      },
    );
  }

  void updatePinned(String id, bool isPinned) async {
    final result = await updatePinnedNoteUseCase.execute(
      UpdatePinnedNoteRequest(id: id, isPinned: isPinned),
    );

    result.when(
      success: (data) {
        fetchNotes();
        countPinnedNotes();
        state = state.copyWith(saveResult: Resource.success('pinned'));
      },
      failure: (error) {
        state = state.copyWith(saveResult: Resource.failure(error));
      },
    );
  }

  void deleteNote(String id) async {
    final result = await deleteNoteUseCase.execute(DeleteNoteRequest(id: id));

    result.when(
      success: (data) {
        fetchNotes();
        state = state.copyWith(deleteResult: Resource.success('note'));
      },
      failure: (error) {
        state = state.copyWith(deleteResult: Resource.failure(error));
      },
    );
  }

  void countPinnedNotes() async {
    final result = await countPinnedNotesUseCase.execute(NoRequest());

    result.when(
      success: (data) {
        state = state.copyWith(countPinnedNotes: Resource.success(data));
      },
      failure: (message) {
        state = state.copyWith(countPinnedNotes: Resource.failure(message));
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
}
