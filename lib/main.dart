import 'package:flutter/material.dart';
import 'package:todo/router.dart';

void main() async{
  runApp(const RefApp());
}

class RefApp extends StatelessWidget {
  const RefApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = TodoAppRouter();
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
