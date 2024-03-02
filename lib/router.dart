import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/apps/auth/presentation/screens/login_screen.dart';
import 'package:todo/apps/auth/presentation/screens/profile_screen.dart';
import 'package:todo/apps/auth/presentation/screens/signup_screen.dart';
import 'package:todo/apps/core/presentation/screens/list_todos_screen.dart';
import 'package:todo/apps/core/presentation/screens/write_todo_screen.dart';
import 'package:todo/apps/core/presentation/screens/base_screen.dart';
import 'package:todo/apps/core/presentation/screens/home_screen.dart';
import 'package:todo/apps/core/presentation/screens/splash_screen.dart';



class TodoAppRouter extends GoRouter {
  TodoAppRouter()
      : super(routes: [


      // ShellRoute(
      //   builder: (context, state, child) => BaseScreen(child),
      //     routes: [
      //       GoRoute(path: "/", builder: (context, state) => ListTodosScreen())
      //     ]
      // ),

    GoRoute(path: "/", builder: (context, state) => SplashScreen(key: Key(DateTime.now().toIso8601String()))),

    GoRoute(path: "/auth/login", builder: (context, state) => const LoginScreen()),
    GoRoute(path: "/auth/signup", builder: (context, state) => const SignupScreen()),

    ShellRoute(
        builder: (context, state, child) => BaseScreen(child),
        routes: [
          GoRoute(path: "/core/home", builder: (context, state) => const HomeScreen()),
          GoRoute(path: "/core/todo/add", builder: (context, state) => const WriteTodoScreen()),
          GoRoute(path: "/core/todo/edit", builder: (context, state) => WriteTodoScreen(todoId: state.extra as String)),
          GoRoute(path: "/core/todo/all", builder: (context, state) => const ListTodosScreen()),
          GoRoute(path: "/core/todo/category", builder: (context, state) => ListTodosScreen(categoryId: state.extra as String,)),

          GoRoute(path: "/auth/profile", builder: (context, state) => const ProfileScreen())
        ]
    ),

  ]);

}
