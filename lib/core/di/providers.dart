import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/domain/usecases/get_note_list_usecase.dart';

final noteRepositoryProvider = Provider((ref) => NoteRepository());
