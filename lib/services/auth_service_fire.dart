import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// value notifier for auth service to listen to changes in the auth state of the user and update the UI accordingly
ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  /// Firebase Auth Instance for authentication related operations in the app
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// Get the current user
  User? get currentUser => firebaseAuth.currentUser;

  /// Stream of auth changes to listen to changes in the user auth state
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  /// login the user with email and password
  Future<UserCredential> signInWithEmailPassword(
      {required String email, required String password}) async {
    /// We can return directly like this in commented line
    /// return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  /// create a new user with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    /// We can return directly like this in commented line
    /// return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  /// sign out the user from the app
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  /// reset the password of the user
  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// update the Username of the user
  Future<void> updateUsername({required String username}) async {
    await currentUser!.updateDisplayName(username);
  }

  /// delete the user account
  Future<void> deleteAccount(
      {required String email, required String password}) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }

  /// reset the password of the user
  Future<void> resetPasswordFromCurrentPassword(
      {required String currentPassword,
      required String newPassword,
      required String email}) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: currentPassword);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: ['email'],
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


  /// Phone auth
  String verificationId = '';
  String currentPhone = '';

  Future<void> verifyPhoneNumber({required String phone}) async {
    await firebaseAuth.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await firebaseAuth.signInWithCredential(credential);
          log("✅ Auto-verification successful");
          // notifyListeners();
        } catch (e) {
          log("❌ Auto-verification failed: $e");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        log("❌ Verification failed: ${e.message}");
      },
      codeSent: (String vId, int? resendToken) {
        verificationId = vId;
        currentPhone = phone;
        log("📩 Code sent. Verification ID saved. vId is $vId");
        // notifyListeners();
      },
      phoneNumber: phone,
      codeAutoRetrievalTimeout: (String vId) {
        verificationId = vId; // ✅ Fallback storage
      },
    );
    currentPhone = phone;
    // notifyListeners();
  }


  Future<PhoneAuthCredential> credential(String textOTP) async {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: textOTP,
    );
  }

  Future<UserCredential> userCredentialUsingPhoneAuthCredential(PhoneAuthCredential credential) {
    return firebaseAuth.signInWithCredential(credential);
  }
}
