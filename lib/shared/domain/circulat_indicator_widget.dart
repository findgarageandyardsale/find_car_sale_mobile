import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Image loading circular indicator
class CircularIndicatorWidget extends StatelessWidget {
  const CircularIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
