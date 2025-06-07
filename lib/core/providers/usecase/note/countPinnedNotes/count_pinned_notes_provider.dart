import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/note.dart';
import 'package:eling/domain/usecases/note/countPinnedNotes/count_pinned_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'count_pinned_notes_provider.g.dart';

@riverpod
CountPinnedNotesUseCase countPinnedNotesUseCase(Ref ref) {
  return CountPinnedNotesUseCaseImpl(
    logger: ref.watch(loggerProvider),
    noteRepository: ref.watch(noteRepositoryProvider),
  );
}
