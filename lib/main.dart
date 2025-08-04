import 'package:advanced_task_manager/config/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Challenge App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        builder: (context, child) =>
            SafeArea(child: child ?? const SizedBox.shrink()),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => context.push('/task_manager'),
                child: Text("Administrador de Tareas"),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () => context.push('/countries'),
                child: Text("Países"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
