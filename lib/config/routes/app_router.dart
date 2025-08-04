import 'package:advanced_task_manager/countries/presentation/pages/countries_list_page.dart';
import 'package:advanced_task_manager/main.dart';
import 'package:advanced_task_manager/task_manager/presentation/pages/task_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        // Import the Calculator widget here to avoid circular dependencies
        // and to ensure that the widget is only loaded when this route is accessed.
        return Home();
      },
    ),
    GoRoute(
      path: '/task_manager',
      builder: (context, state) {
        // Import the Calculator widget here to avoid circular dependencies
        // and to ensure that the widget is only loaded when this route is accessed.
        return TaskPage();
      },
    ),
    GoRoute(
      path: '/countries',
      builder: (context, state) {
        // Import the Calculator widget here to avoid circular dependencies
        // and to ensure that the widget is only loaded when this route is accessed.
        return CountryListPage();
      },
    ),
  ],
);
