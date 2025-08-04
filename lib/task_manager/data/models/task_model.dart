import 'package:advanced_task_manager/task_manager/domain/entities/task_manager_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
sealed class TaskModel with _$TaskModel implements Task {
  const factory TaskModel({
    required int id,
    required String title,
    required String? description,
    required bool completed,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  static TaskModel fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description ?? "",
      completed: task.completed,
    );
  }
}

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      id: reader.readInt(),
      title: reader.readString(),
      description: reader.readString(),
      completed: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description ?? '');
    writer.writeBool(obj.completed);
  }
}
