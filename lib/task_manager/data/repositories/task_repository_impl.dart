import 'package:advanced_task_manager/task_manager/data/datasources/task_manager_datasources.dart';
import 'package:advanced_task_manager/task_manager/data/models/task_manager_models.dart';
import 'package:advanced_task_manager/task_manager/domain/repositories/task_repositories.dart';
import 'package:advanced_task_manager/task_manager/domain/entities/task_manager_entities.dart';
import 'package:advanced_task_manager/task_manager/presentation/providers/task_filter_provider.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApiDatasource taskApiDatasource;
  final TaskHiveDatasource taskHiveDatasource;

  TaskRepositoryImpl({
    required this.taskApiDatasource,
    required this.taskHiveDatasource,
  });

  @override
  Future<List<Task>> getTasks() async {
    List<TaskModel> tasksApi = await taskApiDatasource.getTasks();
    await saveTasks(tasksApi.take(20).toList());
    return await taskHiveDatasource.getTasks();
  }

  @override
  Future<void> addTask(Task task) async {
    taskHiveDatasource.updateTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> updateTask(Task task) async {
    taskHiveDatasource.updateTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    await taskHiveDatasource.saveTasks(
      tasks.map((task) => TaskModel.fromEntity(task)).toList(),
    );
  }

  @override
  Future<List<Task>> getTaskByFilter(TaskFilterType filter) async {
    if (filter == TaskFilterType.all) {
      return await taskHiveDatasource.getTasks();
    }
    return await taskHiveDatasource.getTasksByFilter(
      filter == TaskFilterType.completed,
    );
  }
}
