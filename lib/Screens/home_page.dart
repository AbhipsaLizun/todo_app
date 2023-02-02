import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Screens/dashboard_screen.dart';
import 'package:todo_app/Screens/sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                // log("DATA..." + snapshot.hasData.toString());
                // return Text("data");
                return const DashboardScreen();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(" Something went wrong "),
                );
              } else {
                return const SignInScreen();
              }
            })),
      );
}
