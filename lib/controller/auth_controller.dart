import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cart_provider/repository/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository = AuthRepository();

  Future<UserCredential?> signUp(
    String email,
    String password,
  ) async {
    return await _authRepository.signUp(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?> signIn(
    String email,
    String password,
  ) async {
    return await _authRepository.signin(
      email: email,
      password: password,
    );
  }

  // void deleteUserAccountAndData() {
  //   _authRepository.deleteUserAccount();
  // }

  // void resetPassword(String email) async {
  //   try {
  //     _authRepository.resetPassword(email);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<bool> checkIfUserExists(
  //   String email,
  // ) async {
  //   return await _authRepository.checkIfUserExist(email);
  // }
}
