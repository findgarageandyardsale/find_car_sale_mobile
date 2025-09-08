import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/launcher.png',
      height: size ?? 150,
      width: size ?? 150,
    );
  }
}
