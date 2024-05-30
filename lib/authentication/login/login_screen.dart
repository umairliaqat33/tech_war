// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart_provider/authentication/components/other_auth_option.dart';
import 'package:flutter_cart_provider/config/size_config.dart';
import 'package:flutter_cart_provider/home.dart';
import 'package:flutter_cart_provider/utils/exceptions.dart';
import 'package:flutter_cart_provider/utils/utils.dart';
import 'package:flutter_cart_provider/widgets/text_fields/password_text_field.dart';
import 'package:flutter_cart_provider/widgets/text_fields/text_form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_cart_provider/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;

  @override
  void dispose() {
    _passController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.width15(context),
              right: SizeConfig.width15(context),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.height20(context) * 7,
                    ),
                    Column(
                      children: [
                        TextFormFieldWidget(
                          label: 'Email',
                          controller: _emailController,
                          validator: (value) => Utils.emailValidator(value),
                          hintText: "Johndoe@gmail.com",
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: SizeConfig.height8(context),
                        ),
                        PasswordTextField(controller: _passController),
                        SizedBox(
                          height: SizeConfig.height12(context),
                        ),
                        _showSpinner
                            ? Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.width12(context) * 10,
                                  right: SizeConfig.width12(context) * 10,
                                ),
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () => signin(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    elevation: 10,
                                  ),
                                  child: const Text('Sign In',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.height20(context),
                    ),
                    const OtherAuthOption(
                      optionText: 'Don\'t',
                      authOptiontext: 'Sign up',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signin() async {
    // FocusManager.instance.primaryFocus?.unfocus();
    AuthController authController = AuthController();
    UserCredential? userCredential;
    setState(() {
      log("i got set to true");
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        userCredential = await authController.signIn(
          _emailController.text,
          _passController.text,
        );
        if (userCredential != null) {
          Fluttertoast.showToast(msg: "Login Successfull");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false,
          );
        }
      }
    } on IncorrectPasswordOrUserNotFound catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
