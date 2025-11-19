import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/hash.dart';

class AuthServiceWithFireStore {
  final _db = FirebaseFirestore.instance;

  /// SIGNUP
  Future<String?> signUp(String phone, String password, String email) async {
    final hashed = hashPassword(password);

    final existing =
        await _db.collection("users").where("phone", isEqualTo: phone).get();

    if (existing.docs.isNotEmpty) return "Phone already registered";

    await _db.collection("users").add({
      "phone": phone,
      "password": hashed,
      "email": email,
      "createdAt": DateTime.now(),
    });

    return null;
  }

  /// CHECK IF USER EXISTS
  Future<bool> userExists(String phone) async {
    final query =
        await _db.collection("users").where("phone", isEqualTo: phone).get();

    return query.docs.isNotEmpty;
  }
}
