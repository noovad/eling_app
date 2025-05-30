import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/note_repository.dart';
import 'package:eling_app/domain/entities/note/note.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';

abstract class GetNotesUseCase {
  Future<Result<List<NoteEntity>>> execute(NoRequest request);
}

class GetNotesUseCaseImpl extends BaseUsecase<NoRequest, List<NoteEntity>>
    implements GetNotesUseCase {
  final NoteRepository _noteRepository;

  @override
  String get usecaseName => 'GetNotesUseCase';

  GetNotesUseCaseImpl({
    required super.logger,
    required NoteRepository noteRepository,
  }) : _noteRepository = noteRepository;

  @override
  Future<Result<List<NoteEntity>>> execute(NoRequest request) async {
    return safeExecute(request, () async {
      final result = _noteRepository.readAllNotes();
      return result;
    });
  }
}
