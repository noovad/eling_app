import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/note_repository.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/note/deleteNote/delete_note_request.dart';

abstract class DeleteNoteUseCase {
  Future<Result<int>> execute(DeleteNoteRequest request);
}

class DeleteNoteUseCaseImpl extends BaseUsecase<DeleteNoteRequest, int>
    implements DeleteNoteUseCase {
  final NoteRepository _noteRepository;

  @override
  String get usecaseName => 'DeleteNoteUseCase';

  DeleteNoteUseCaseImpl({
    required super.logger,
    required NoteRepository noteRepository,
  }) : _noteRepository = noteRepository;

  @override
  Future<Result<int>> execute(DeleteNoteRequest request) async {
    return safeExecute(request, () async {
      final result = _noteRepository.deleteNote(request.id);
      return result;
    });
  }
}
