import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luxeloft/services/phone_auth_service.dart';

import 'auth_service_with_fire_store.dart';

class AuthService extends ChangeNotifier {
  /// code from auth service fire start
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
  signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: ['email'],
      serverClientId: "236436825228-9bdt9te2af0g7bdujcsv60i80qiuae88.apps.googleusercontent.com",
    );
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    if (gUser == null) return;
    final GoogleSignInAuthentication googleAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await firebaseAuth.signInWithCredential(credential);
  }
  /// code from auth service fire end

  final authServiceWithFireStore = AuthServiceWithFireStore();
  final phoneAuth = PhoneAuthService();

  bool isLoading = false;

  String? verificationId;
  /// SIGNUP FLOW
  Future<String?> signUp({required String phone, required String password, required String email}) async {
    isLoading = true;
    notifyListeners();
    final String? exists = await authServiceWithFireStore.signUp(phone, password, email);
  if (exists == null) {
    isLoading = false;
    notifyListeners();
    return null;
  } else {
    isLoading = false;
    notifyListeners();
    return "Account already exists";
  }

  }

  /// LOGIN FLOW
  Future<String?> login(String phone) async {
    isLoading = true;
    notifyListeners();

    // 1️⃣ Check if user exists in Firestore
    final exists = await authServiceWithFireStore.userExists(phone);

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
        await firebaseAuth.signInWithCredential(credential);
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

      await firebaseAuth.signInWithCredential(credential);
      return null;
    } catch (e) {
      return "Invalid OTP";
    }
  }
}
