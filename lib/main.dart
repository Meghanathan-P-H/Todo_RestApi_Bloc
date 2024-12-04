import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo_bloc.dart';
import 'package:to_do_app/core/theme/app_theme.dart';
import 'package:to_do_app/screens/splashscree.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => TodoBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: const ScreenSplash(),
    );
  }
}
