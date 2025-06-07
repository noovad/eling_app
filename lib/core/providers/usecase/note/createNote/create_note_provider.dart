import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/note.dart';
import 'package:eling/domain/usecases/note/createNote/create_note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_note_provider.g.dart';

@riverpod
CreateNoteUseCase createNoteUseCase(Ref ref) {
  return CreateNoteUseCaseImpl(
    logger: ref.watch(loggerProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
  );
}
