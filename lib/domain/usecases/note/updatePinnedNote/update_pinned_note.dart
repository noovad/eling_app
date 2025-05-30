import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/note_repository.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/note/updatePinnedNote/update_pinned_note_request.dart';

abstract class UpdatePinnedNoteUseCase {
  Future<Result<int>> execute(UpdatePinnedNoteRequest request);
}

class UpdatePinnedNoteUseCaseImpl
    extends BaseUsecase<UpdatePinnedNoteRequest, int>
    implements UpdatePinnedNoteUseCase {
  final NoteRepository _noteRepository;

  @override
  String get usecaseName => 'UpdatePinnedNoteUseCase';

  UpdatePinnedNoteUseCaseImpl({
    required super.logger,
    required NoteRepository noteRepository,
  }) : _noteRepository = noteRepository;

  @override
  Future<Result<int>> execute(UpdatePinnedNoteRequest request) async {
    return safeExecute(request, () async {
      final result = _noteRepository.updatePinned(request.id, request.isPinned);
      return result;
    });
  }
}
