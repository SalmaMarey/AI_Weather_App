import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<void> signUp(String fullName, String email, String password);
  Future<UserCredential> logIn(String email, String password);
}
