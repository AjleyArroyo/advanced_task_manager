import 'package:advanced_task_manager/task_manager/domain/entities/task.dart';
import 'package:advanced_task_manager/task_manager/presentation/providers/task_manager_providers.dart';
import 'package:advanced_task_manager/task_manager/presentation/widgets/task_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  void showTaskBottomSheetDialog(
    BuildContext context,
    WidgetRef ref, [
    Task? task,
  ]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TaskBottomSheetWidget(initialTask: task),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskProvider = ref.watch(taskListProvider);
    final taskFilter = ref.watch(filteredTaskProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Task Manager", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: taskProvider.when(
        error: (e, st) =>
            Center(child: Text('No se pudo obtener la lista de tareas')),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (tasks) => Column(
          children: [
            SizedBox(height: 12),
            SegmentedButton(
              segments: const [
                ButtonSegment(value: TaskFilterType.all, icon: Text("Todos")),
                ButtonSegment(
                  value: TaskFilterType.completed,
                  icon: Text("Completos"),
                ),
                ButtonSegment(
                  value: TaskFilterType.pending,
                  icon: Text("Pendientes"),
                ),
              ],
              selected: <TaskFilterType>{taskFilter},
              onSelectionChanged: (value) {
                ref.read(filteredTaskProvider.notifier).state = value.first;
                ref
                    .read(taskListProvider.notifier)
                    .getTaskByFilter(value.first);
              },
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, i) {
                  final task = tasks[i];
                  return ListTile(
                    onTap: () => showTaskBottomSheetDialog(context, ref, task),
                    title: Text(task.title),
                    subtitle: Text(task.description ?? ""),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: task.completed,
                          onChanged: (value) {
                            final updated = Task(
                              title: task.title,
                              id: task.id,
                              description: task.description,
                              completed: value,
                            );
                            ref
                                .read(taskListProvider.notifier)
                                .updateTask(updated);
                          },
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTaskBottomSheetDialog(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }
}
