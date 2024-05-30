import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cart_provider/user_model/user_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void uploadUser(UserModel userModel) {
    try {
      _firebaseFirestore
          .collection("techWar")
          .doc(userModel.uid)
          .set(userModel.toJson());
    } catch (e) {
      log("Error in setting user: ${e.toString()}");
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    try {
      _firebaseFirestore
          .collection("techWar")
          .doc(userModel.uid)
          .update(userModel.toJson());
    } catch (e) {
      log("Error in updating user: ${e.toString()}");
    }
  }

  static User? checkUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser;
    } else {
      return null;
    }
  }

  Future<UserModel?> getUser() async {
    UserModel? userModel;
    try {
      final userData = await _firebaseFirestore
          .collection("techWar")
          .doc(FirestoreRepository.checkUser()!.uid)
          .get();
      userModel = UserModel.fromJson(userData.data()!);
    } catch (e) {
      log("Error in getting user: ${e.toString()}");
    }
    return userModel;
  }
}
