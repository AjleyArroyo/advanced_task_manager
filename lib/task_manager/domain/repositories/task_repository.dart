import 'package:advanced_task_manager/task_manager/domain/entities/entities.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask();
  Future<void> updateTask(Task task);
  Future<void> changeState();
}
