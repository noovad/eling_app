import 'package:eling/data/repositories/note_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteRepositoryProvider = Provider((ref) {
  return NoteRepository();
});
