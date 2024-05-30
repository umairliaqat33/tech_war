import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart_provider/authentication/login/login_screen.dart';
import 'package:flutter_cart_provider/config/size_config.dart';
import 'package:flutter_cart_provider/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // UserModel? userModel;

  @override
  void initState() {
    super.initState();
    _createSplash();
    // if (AuthRepository.userLoginStatus()) {
    //   _notificationService.firebaseNotification(context);
    //   getUserData();
    // }
  }

  // Future<void> getUserData() async {
  //   FirestoreController firestoreController = FirestoreController();
  //   userModel = await firestoreController.getUserData();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   Assets.logo,
                //   width: SizeConfig.width20(context) * 7.5,
                //   height: SizeConfig.height20(context) * 7.5,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createSplash() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        log("I am in splash duration");
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          log('No user logged in');
        }
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                user == null ? const LoginScreen() : const Home(),
          ),
          (route) => false,
        );
      },
    );
  }
}
