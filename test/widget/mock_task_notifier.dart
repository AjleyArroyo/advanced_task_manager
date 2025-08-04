import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:advanced_task_manager/task_manager/domain/entities/task.dart';

class MockTaskNotifier extends AsyncNotifier<List<Task>> {
  final List<Task> mockTasks;

  MockTaskNotifier(this.mockTasks);

  @override
  Future<List<Task>> build() async {
    // Aquí devuelves la lista fija para test
    return mockTasks;
  }
}
