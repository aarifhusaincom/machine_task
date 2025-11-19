import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxeloft/screens/nav_screen/nav_screen.dart';
import 'package:luxeloft/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'loading_screen.dart';

class AutoScreen extends StatelessWidget {
  const AutoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    return StreamBuilder(
        stream: auth.authStateChange,
        builder: (context, snapshot) {
          Widget widget;
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   log('Appp.waiting');
          //   widget = const LoadingScreen();
          // } else
            if (snapshot.hasData) {
            log('Appp.has data');
            widget = const NavScreen();
            // widget = const Center(child: Text('Something went wrong!'));
          } else {
            log('Appp. has no data so go to OnboardingScreen');
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) =>const OnboardingScreen()),
            //         (route) => false);
            widget = const OnboardingScreen();
          }
          return widget;
        });
  }
  // @override
  // Widget build(BuildContext context) {
  //   return ValueListenableBuilder(
  //       valueListenable: authService,
  //       builder: (context, authService, child) {
  //         return StreamBuilder(
  //             stream: authService.authStateChange,
  //             builder: (context, snapshot) {
  //               Widget widget;
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 widget = const LoadingScreen();
  //               } else if (snapshot.hasData) {
  //                 widget = const NavScreen();
  //                 // widget = const Center(child: Text('Something went wrong!'));
  //               } else {
  //                 widget = const OnboardingScreen();
  //               }
  //               return widget;
  //             });
  //       });
  // }
}
