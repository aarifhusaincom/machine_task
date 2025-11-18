import 'package:flutter/material.dart';
import 'package:luxeloft/screens/nav_screen/nav_screen.dart';
import 'package:luxeloft/screens/onboarding/onboarding_screen.dart';
import 'package:luxeloft/services/auth_service_fire.dart';

import 'loading_screen.dart';

class AutoScreen extends StatelessWidget {
  const AutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: authService,
        builder: (context, authService, child) {
          return StreamBuilder(
              stream: authService.authStateChange,
              builder: (context, snapshot) {
                Widget widget;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  widget = const LoadingScreen();
                } else if (snapshot.hasData) {
                  widget = const NavScreen();
                  // widget = const Center(child: Text('Something went wrong!'));
                } else {
                  widget = const OnboardingScreen();
                }
                return widget;
              });
        });
  }
}
