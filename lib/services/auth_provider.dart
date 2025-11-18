import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxeloft/services/phone_auth_service.dart';

import 'auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final authService = AuthService();
  final phoneAuth = PhoneAuthService();

  bool isLoading = false;

  String? verificationId;

  /// LOGIN FLOW
  Future<String?> login(String phone) async {
    isLoading = true;
    notifyListeners();

    // 1️⃣ Check if user exists in Firestore
    final exists = await authService.userExists(phone);

    if (!exists) {
      isLoading = false;
      notifyListeners();
      return "Account not found, please signup";
    }

    // 2️⃣ User exists → send OTP
    await phoneAuth.sendOTP(
      phone: "+91$phone",
      onCodeSent: (id) {
        verificationId = id;
        isLoading = false;
        notifyListeners();
      },
      onAutoVerified: (credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        isLoading = false;
        notifyListeners();
      },
      onFailed: (err) {
        isLoading = false;
        notifyListeners();
      },
    );

    return null;
  }

  /// OTP VERIFY
  Future<String?> verifyOTP(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      return null;
    } catch (e) {
      return "Invalid OTP";
    }
  }
}
