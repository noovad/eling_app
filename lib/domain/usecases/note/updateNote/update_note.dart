import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/note_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/note/updateNote/update_note_request.dart';

abstract class UpdateNoteUseCase {
  Future<Result<int>> execute(UpdateNoteRequest request);
}

class UpdateNoteUseCaseImpl extends BaseUsecase<UpdateNoteRequest, int>
    implements UpdateNoteUseCase {
  final NoteRepository _noteRepository;

  @override
  String get usecaseName => 'UpdateNoteUseCase';

  UpdateNoteUseCaseImpl({
    required super.logger,
    required NoteRepository noteRepository,
  }) : _noteRepository = noteRepository;

  @override
  Future<Result<int>> execute(UpdateNoteRequest request) async {
    return safeExecute(request, () async {
      final result = _noteRepository.updateNote(request.note);
      return result;
    });
  }
}
