import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TaskFilterType { all, pending, completed }

final filteredTaskProvider = StateProvider.autoDispose(
  (ref) => TaskFilterType.all,
);
