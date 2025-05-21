import 'package:my_app/core/utils/result.dart';
import 'package:my_app/domain/entities/note.dart';
import 'package:my_app/domain/usecases/base_usecase.dart';

abstract class GetNotesUseCase {
  Future<Result<List<NoteEntity>>> execute(NoRequest request);
}

class GetNotesUseCaseImpl extends BaseUsecase<NoRequest, List<NoteEntity>>
    implements GetNotesUseCase {
  @override
  String get usecaseName => 'GetNotesUseCase';

  GetNotesUseCaseImpl({required super.logger});

  @override
  Future<Result<List<NoteEntity>>> execute(NoRequest request) async {
    return safeExecute(request, () async {
      await Future.delayed(const Duration(seconds: 2));
      return [
        NoteEntity(
          id: '1',
          title: 'First Note',
          content: 'This is the content of the first note.',
          category: 'Work',
          isPinned: false,
        ),
        NoteEntity(
          id: '2',
          title: 'Second Note',
          content: 'This is the content of the second note.',
          isPinned: true,
        ),
      ];
    });
  }
}
