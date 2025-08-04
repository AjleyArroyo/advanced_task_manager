import 'package:advanced_task_manager/task_manager/domain/entities/task_manager_entities.dart';
import 'package:advanced_task_manager/task_manager/presentation/providers/task_manager_providers.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<List<Task>> getTaskByFilter(TaskFilterType filter);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> saveTasks(List<Task> tasks);
}
