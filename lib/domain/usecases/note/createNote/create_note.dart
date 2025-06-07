import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/note_repository.dart';
import 'package:eling/domain/entities/note/note.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/note/createNote/create_note_request.dart';

abstract class CreateNoteUseCase {
  Future<Result<NoteEntity>> execute(CreateNoteRequest request);
}

class CreateNoteUseCaseImpl extends BaseUsecase<CreateNoteRequest, NoteEntity>
    implements CreateNoteUseCase {
  final NoteRepository _noteRepository;
  @override
  String get usecaseName => 'CreateNoteUseCase';

  CreateNoteUseCaseImpl({
    required super.logger,
    required NoteRepository noteRepository,
  }) : _noteRepository = noteRepository;

  @override
  Future<Result<NoteEntity>> execute(CreateNoteRequest request) async {
    return safeExecute(request, () async {
      final result = _noteRepository.createNote(request.note);
      return result;
    });
  }
}
