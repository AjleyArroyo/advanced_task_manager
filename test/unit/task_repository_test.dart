import 'package:advanced_task_manager/task_manager/data/datasources/task_manager_datasources.dart';
import 'package:advanced_task_manager/task_manager/data/models/task_manager_models.dart';
import 'package:advanced_task_manager/task_manager/data/repositories/task_data_repositories.dart';
import 'package:advanced_task_manager/task_manager/domain/entities/task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'task_repository_test.mocks.dart';

// class MockDatasourceApi extends Mock implements TaskApiDatasource {}

// class MockDatasourceHive extends Mock implements TaskHiveDatasource {}

@GenerateMocks([TaskApiDatasource, TaskHiveDatasource])
void main() {
  late MockTaskApiDatasource mockDatasourceApi;
  late MockTaskHiveDatasource mockDatasourceHive;
  late TaskRepositoryImpl repository;

  setUp(() {
    mockDatasourceApi = MockTaskApiDatasource();
    mockDatasourceHive = MockTaskHiveDatasource();
    repository = TaskRepositoryImpl(
      taskApiDatasource: mockDatasourceApi,
      taskHiveDatasource: mockDatasourceHive,
    );
  });

  test('debe retornar lista de tareas desde el datasource', () async {
    final mockTasks = [
      Task(
        id: 1,
        title: 'Tarea 1',
        description: 'descripcion 1',
        completed: false,
      ),
      Task(
        id: 2,
        title: 'Tarea 2',
        description: 'descripcion 2',
        completed: true,
      ),
    ];

    final mockTaskModels = mockTasks
        .map(
          (t) => TaskModel(
            id: t.id,
            title: t.title,
            description: t.description,
            completed: t.completed,
          ),
        )
        .toList();

    when(mockDatasourceApi.getTasks()).thenAnswer((_) async => mockTaskModels);
    when(mockDatasourceHive.getTasks()).thenAnswer((_) async => mockTaskModels);

    final result = await repository.getTasks();

    expect(result, equals(mockTaskModels));
    verify(mockDatasourceHive.getTasks()).called(1);
  });
}
