import 'package:flutter/material.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Screens/sign_in.dart';

import 'background/onboardbg.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return OnBoardBackground(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/images/onboard.png",
                    fit: BoxFit.cover,
                    //height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Smart Task \nManagement",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Merriweather',
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "This smart tool is designed to help you  better manage your tasks.",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w100,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: Container(
                      height: 50,
                      //width: MediaQuery.of(context).size.width,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          //border: Border.all(width: 1.5, color: Colors.amber),
                          gradient: const LinearGradient(
                              colors: [Colors.orange, Colors.pink])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: Text(
                              "Continue ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
