import 'package:flutter/material.dart';

import 'package:twitter/components/components.dart';
import 'package:twitter/modules/login/login.dart';
import 'package:twitter/modules/register/register.dart';

class Submit extends StatelessWidget {
  const Submit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 100,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'See what’s happening in the world right now',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 0.4,
                            offset: const Offset(0, 0.7),
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: button(
                      text: "Log In",
                      function: () {
                        navigatorPushReplacement(
                            context: context, widget: Login());
                      }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 0.4,
                            offset: const Offset(0, 0.7),
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: button(
                      text: "Register",
                      function: () {
                        navigatorPushReplacement(
                            context: context, widget: Register());
                      }),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
