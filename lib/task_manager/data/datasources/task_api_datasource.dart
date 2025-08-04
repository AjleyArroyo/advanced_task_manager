import 'package:advanced_task_manager/task_manager/data/models/task_manager_models.dart';
import 'package:dio/dio.dart';

abstract class TaskApiDatasource {
  Future<List<TaskModel>> getTasks();
}

class TaskApiDatasourceImpl implements TaskApiDatasource {
  final Dio dio = Dio(
    BaseOptions(
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'en-US,en;q=0.9',
        'Connection': 'keep-alive',
      },
    ),
  );
  @override
  Future<List<TaskModel>> getTasks() async {
    final resp = await dio.get('https://jsonplaceholder.typicode.com/todos/');
    final data = resp.data as List;
    // Mapear cada item JSON a un TaskModel
    return data
        .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
