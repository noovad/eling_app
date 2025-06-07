import 'package:eling/data/repositories/recurring_task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recurringTaskRepositoryProvider = Provider((ref) {
  return RecurringTaskRepository();
});
