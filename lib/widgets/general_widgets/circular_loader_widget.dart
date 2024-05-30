import 'package:flutter/material.dart';

class CircularLoaderWidget extends StatelessWidget {
  const CircularLoaderWidget({
    super.key,
    this.loaderColor = Colors.yellow,
  });
  final Color loaderColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
      ),
    );
  }
}
