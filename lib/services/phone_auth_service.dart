import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthService {
  final auth = FirebaseAuth.instance;

  Future<void> sendOTP({
    required String phone,
    required Function(String verificationId) onCodeSent,
    required Function(PhoneAuthCredential credential) onAutoVerified,
    required Function(String error) onFailed,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        onAutoVerified(credential); // Auto verified (instant login)
      },
      verificationFailed: (e) {
        onFailed(e.message ?? "Verification failed");
      },
      codeSent: (String verificationId, int? forceResend) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
