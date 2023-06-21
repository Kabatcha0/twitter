import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/layout/layout.dart';
import 'package:twitter/modules/login/login_cubit/login_cubit.dart';
import 'package:twitter/modules/login/login_cubit/login_states.dart';
import 'package:twitter/modules/register/register.dart';

class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(builder: (context, state) {
      var cubit = LayoutCubit.get(context);
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
                  width: 70,
                  height: 70,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                textFromField(
                    hint: "Enter your email",
                    textInputType: TextInputType.emailAddress,
                    textEditingController: email),
                const SizedBox(
                  height: 15,
                ),
                textFromField(
                    hint: "Enter your pass",
                    textInputType: TextInputType.name,
                    textEditingController: pass),
                const SizedBox(
                  height: 25,
                ),
                if (state is LogInLoadingState) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
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
                        text: "LogIn",
                        function: () {
                          cubit.logIn(email: email.text, password: pass.text);
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
    }, listener: (context, state) {
      if (state is LogInSuccessState) {
        navigatorPushReplacement(context: context, widget: const Layout());
      }
    });
  }
}
