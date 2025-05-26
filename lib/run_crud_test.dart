import 'package:eling_app/data/repositories/task_repository.dart';
import 'package:eling_app/domain/entities/task/task.dart';

Future<void> runCrudTest() async {
  final repository = TaskRepository();

  final task = TaskEntity(
    id: '1',
    title: 'Coba Insert via Repository',
    note: 'Catatan penting',
    date: DateTime.now(),
    time: '10:00',
    category: 'work',
    isDone: false,
  );

  // CREATE
  final created = await repository.createTask(task);
  print('Created: $created');

  // READ
  final fetched = await repository.readTask('1');
  print('Fetched: $fetched');

  // UPDATE
  // final updated = await repository.updateTask(task.copyWith(title: 'Judul Diupdate'));
  // print('Rows updated: $updated');

  // // READ ALL
  // final all = await repository.readAllTasks();
  // print('All tasks: $all');

  // // DELETE
  // final deleted = await repository.deleteTask('1');
  // print('Rows deleted: $deleted');
}
