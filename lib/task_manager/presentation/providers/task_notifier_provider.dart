import 'package:advanced_task_manager/task_manager/data/datasources/task_manager_datasources.dart';
import 'package:advanced_task_manager/task_manager/data/repositories/task_data_repositories.dart';
import 'package:advanced_task_manager/task_manager/domain/entities/task_manager_entities.dart';
import 'package:advanced_task_manager/task_manager/presentation/providers/task_manager_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskRepositoryProvider = Provider<TaskRepositoryImpl>((ref) {
  return TaskRepositoryImpl(
    taskApiDatasource: TaskApiDatasourceImpl(),
    taskHiveDatasource: TaskHiveDatasourceImpl(),
  );
});

final taskListProvider =
    StateNotifierProvider<TaskNotifierProvider, AsyncValue<List<Task>>>((ref) {
      final repository = ref.watch(taskRepositoryProvider);
      return TaskNotifierProvider(repository);
    });

class TaskNotifierProvider extends StateNotifier<AsyncValue<List<Task>>> {
  final TaskRepositoryImpl repository;
  TaskFilterType _currentFilter = TaskFilterType.all;
  int lastId = 0;

  TaskNotifierProvider(this.repository) : super(const AsyncValue.loading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final tasks = await repository.getTasks();
      lastId = tasks.length;
      state = AsyncValue.data(tasks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> saveTask(Task task) async {
    if (state case AsyncData(:final value)) {
      try {
        await repository.updateTask(task);
        lastId++;
        state = AsyncValue.data([...value, task]);
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await repository.updateTask(updatedTask);
      await getTaskByFilter(_currentFilter);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> getTaskByFilter(TaskFilterType filter) async {
    try {
      _currentFilter = filter;
      final tasks = await repository.getTaskByFilter(filter);
      state = AsyncValue.data(tasks);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
