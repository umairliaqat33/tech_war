import 'package:flutter/material.dart';
import 'package:flutter_cart_provider/authentication/login/login_screen.dart';
import 'package:flutter_cart_provider/authentication/registration/registration_screen.dart';

class OtherAuthOption extends StatelessWidget {
  const OtherAuthOption({
    super.key,
    required this.optionText,
    required this.authOptiontext,
  });
  final String optionText;
  final String authOptiontext;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$optionText have an account? '),
        TextButton(
          style: const ButtonStyle(
              splashFactory:
                  NoSplash.splashFactory //removing onClick splash color
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => authOptiontext == "Sign up"
                    ? const RegistrationScreen()
                    : const LoginScreen(),
              ),
            );
          },
          child: Text(
            authOptiontext,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
