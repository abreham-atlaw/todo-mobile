import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/apps/auth/data/models/authentication_status.dart';
import 'package:todo/common/widgets/screens/app_scaffold.dart';
import 'package:todo/common/widgets/screens/authenticated_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: AuthenticatedScreen(
          validStatuses: const [],
          redirectMap: const { // Redirect the user depending on the Authentication Status
            AuthenticationStatus.authenticated: "/core/home",
            AuthenticationStatus.none: "/auth/login"
          },
          child: const SizedBox.shrink(),
      ),
    );
  }

}
