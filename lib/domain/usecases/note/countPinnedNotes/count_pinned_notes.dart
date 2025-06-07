import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/note_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';

abstract class CountPinnedNotesUseCase {
  Future<Result<int>> execute(NoRequest request);
}

class CountPinnedNotesUseCaseImpl extends BaseUsecase<NoRequest, int>
    implements CountPinnedNotesUseCase {
  final NoteRepository _noteRepository;
  @override
  String get usecaseName => 'CountPinnedNotesUseCase';

  CountPinnedNotesUseCaseImpl({
    required super.logger,
    required NoteRepository noteRepository,
  }) : _noteRepository = noteRepository;

  @override
  Future<Result<int>> execute(NoRequest request) async {
    return safeExecute(request, () async {
      final result = await _noteRepository.countPinnedNotes();
      return result;
    });
  }
}
