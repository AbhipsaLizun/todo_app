import 'package:flutter/material.dart';

class ToDoBackground extends StatelessWidget {
  final Widget child;
  const ToDoBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(color: Colors.black),
      child: child,
    );
  }
}
