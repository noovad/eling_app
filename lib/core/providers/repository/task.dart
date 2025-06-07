import 'package:eling/data/repositories/task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskRepositoryProvider = Provider((ref) {
  return TaskRepository();
});
