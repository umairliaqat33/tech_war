// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart_provider/authentication/components/other_auth_option.dart';
import 'package:flutter_cart_provider/config/size_config.dart';
import 'package:flutter_cart_provider/controller/auth_controller.dart';
import 'package:flutter_cart_provider/controller/firestore_controller.dart';
import 'package:flutter_cart_provider/home.dart';
import 'package:flutter_cart_provider/user_model/user_model.dart';
import 'package:flutter_cart_provider/utils/exceptions.dart';
import 'package:flutter_cart_provider/utils/utils.dart';
import 'package:flutter_cart_provider/widgets/text_fields/password_text_field.dart';
import 'package:flutter_cart_provider/widgets/text_fields/text_form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.height20(context) * 3,
                  ),
                  Column(
                    children: [
                      TextFormFieldWidget(
                        label: 'Name',
                        controller: _nameController,
                        validator: (value) => Utils.nameValidator(value),
                        hintText: "John Doe",
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: SizeConfig.height8(context),
                      ),
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
                      TextFormFieldWidget(
                        label: 'Address',
                        controller: _addressController,
                        validator: (value) => Utils.addressValidator(value),
                        hintText: "Wahdat Road",
                        inputType: TextInputType.text,
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
                                onPressed: () => signup(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  elevation: 10,
                                ),
                                child: const Text('Checkout',
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
                    optionText: 'Already',
                    authOptiontext: 'Sign in',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signup() async {
    FocusManager.instance.primaryFocus?.unfocus();
    AuthController authController = AuthController();
    FirestoreController firestoreController = FirestoreController();
    UserCredential? userCredential;

    setState(() {
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        log("going to register");
        userCredential = await authController.signUp(
          _emailController.text,
          _passController.text,
        );
        if (userCredential != null) {
          firestoreController.uploadUser(
            UserModel(
              email: _emailController.text,
              name: _nameController.text,
              uid: userCredential.user!.uid,
            ),
          );
          log("Signup Successful");
          Fluttertoast.showToast(msg: 'Signup Successful');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false,
          );
        }
      }
    } on EmailAlreadyExistException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Signup failed");
      Fluttertoast.showToast(msg: 'Signup Failed');
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Signup failed");
      Fluttertoast.showToast(msg: 'Signup Failed');
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
