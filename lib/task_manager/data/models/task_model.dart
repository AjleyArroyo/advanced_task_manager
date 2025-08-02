import 'package:advanced_task_manager/task_manager/domain/entities/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

class TaskModel with $TaskModel implements Task {
  const factory TaskModel({
    required String id,
    required String title,
    required String description,
    required bool state,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
