

import 'package:flutter_cart_provider/repository/firestore_repository.dart';
import 'package:flutter_cart_provider/user_model/user_model.dart';

class FirestoreController {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  void uploadUser(UserModel userModel) {
    _firestoreRepository.uploadUser(userModel);
  }

  void updateUser(UserModel userModel) {
    _firestoreRepository.updateUser(userModel);
  }

  Future<UserModel?> getUserModel() {
    return _firestoreRepository.getUser();
  }
}
