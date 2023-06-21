import 'dart:async';
import 'package:flutter/material.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/modules/submit.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      navigatorPushReplacement(context: context, widget: const Submit());
    });
    super.initState();
  }

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
                width: 120,
                height: 120,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
