import 'package:flutter/material.dart';
import 'package:todo_app/Screens/onboard_screen.dart';
import 'background/background_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);

    animation =
        //Tween<double>(begin: 0, end: 2 * pi).animate(animationController);
        CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardScreen()),
      );
    });
    return ToDoBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 240,
                      width: 260,
                      child: ScaleTransition(
                        alignment: Alignment.bottomCenter,
                        scale: animation,
                        child: Image.asset(
                          "assets/images/todologo.png",
                          height: 250,
                          width: 250,
                        ),
                      ))
                ],
              ),
            )
          ]),
        )),
      ),
    );
  }
}
