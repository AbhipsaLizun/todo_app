import 'package:flutter/material.dart';

class OnBoardBackground extends StatelessWidget {
  final Widget child;
  const OnBoardBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          //color: Color.fromARGB(246, 183, 129, 249),
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.jpg",
            ),
            opacity: 400.0,
            fit: BoxFit.cover,
          )),
      child: child,
    );
  }
}
