import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/note.dart';
import 'package:eling/domain/usecases/note/updateNote/update_note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_note_provider.g.dart';

@riverpod
UpdateNoteUseCase updateNoteUseCase(Ref ref) {
  return UpdateNoteUseCaseImpl(
    logger: ref.watch(loggerProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
  );
}
