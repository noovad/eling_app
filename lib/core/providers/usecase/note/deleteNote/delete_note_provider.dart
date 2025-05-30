import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/note.dart';
import 'package:eling_app/domain/usecases/note/deleteNote/delete_note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_note_provider.g.dart';

@riverpod
DeleteNoteUseCase deleteNoteUseCase(Ref ref) {
  return DeleteNoteUseCaseImpl(
    logger: ref.watch(loggerProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
  );
}
