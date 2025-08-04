import 'package:advanced_task_manager/task_manager/data/models/task_manager_models.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TaskHiveDatasource {
  Future<void> saveTasks(List<TaskModel> tasks);
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> getTasksByFilter(bool isCompleted);
  Future<bool> updateTask(TaskModel task);
  Future<TaskModel?> getTask(int id);
}

class TaskHiveDatasourceImpl implements TaskHiveDatasource {
  TaskHiveDatasourceImpl() {
    Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
  }

  @override
  Future<void> saveTasks(List<TaskModel> tasks) async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>('tasks');
    for (var task in tasks) {
      await box.put(task.id, task);
    }
    await box.close();
  }

  @override
  Future<bool> updateTask(TaskModel task) async {
    try {
      Box<TaskModel> box = await Hive.openBox<TaskModel>('tasks');
      await box.put(task.id, task);
      await box.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<TaskModel?> getTask(int id) async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>('tasks');
    return box.get(id);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>('tasks');
    return box.values.toList();
  }

  @override
  Future<List<TaskModel>> getTasksByFilter(bool isCompleted) async {
    Box<TaskModel> box = await Hive.openBox<TaskModel>('tasks');
    final allTasks = box.values.toList();
    final filteredTask = allTasks
        .where((task) => task.completed == isCompleted)
        .toList();

    return filteredTask;
  }
}
