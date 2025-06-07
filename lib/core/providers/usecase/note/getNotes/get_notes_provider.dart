import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/note.dart';
import 'package:eling/domain/usecases/note/getNotes/get_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_notes_provider.g.dart';

@riverpod
GetNotesUseCase getNotesUseCase(Ref ref) {
  return GetNotesUseCaseImpl(
    logger: ref.watch(loggerProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
  );
}
