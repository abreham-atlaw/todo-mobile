import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/apps/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:todo/common/widgets/screens/authenticated_screen.dart';

class BaseScreen extends StatelessWidget{

  final Widget _child;

  const BaseScreen(this._child, {super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticatedScreen(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: _child),
            TodoAppBottomNavBar()
          ],
        ),
      ),
    );
  }

}