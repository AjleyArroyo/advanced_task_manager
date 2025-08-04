import 'package:advanced_task_manager/task_manager/domain/entities/task_manager_entities.dart';
import 'package:advanced_task_manager/task_manager/presentation/providers/task_manager_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskBottomSheetWidget extends ConsumerStatefulWidget {
  final Task? initialTask;

  const TaskBottomSheetWidget({super.key, this.initialTask});

  @override
  ConsumerState<TaskBottomSheetWidget> createState() =>
      _TaskBottomSheetWidgetState();
}

class _TaskBottomSheetWidgetState extends ConsumerState<TaskBottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.initialTask?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialTask?.description ?? '',
    );
    _completed = widget.initialTask?.completed ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final newTask = Task(
      id:
          widget.initialTask?.id ??
          ref.read(taskListProvider.notifier).lastId + 1,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      completed: _completed,
    );

    if (widget.initialTask == null) {
      ref.read(taskListProvider.notifier).saveTask(newTask);
    } else {
      ref.read(taskListProvider.notifier).updateTask(newTask);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.initialTask == null ? 'Crear tarea' : 'Editar tarea',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título no puede estar vacío';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Está finalizado?'),
                  Switch(
                    value: _completed,
                    onChanged: (value) => setState(() => _completed = value),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.blueGrey,
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.black,
                    ),
                  ),
                  onPressed: _onSave,
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
