import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/layout/layout.dart';
import 'package:twitter/modules/login/login.dart';
import 'package:twitter/modules/register/register_cubit/register_cubit.dart';
import 'package:twitter/modules/register/register_cubit/register_states.dart';

import '../../layout/cubit/cubit.dart';

class Register extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                    hint: "Enter your name",
                    textInputType: TextInputType.name,
                    textEditingController: name),
                const SizedBox(
                  height: 15,
                ),
                textFromField(
                    hint: "Enter your phone",
                    textInputType: TextInputType.phone,
                    textEditingController: phone),
                const SizedBox(
                  height: 15,
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
                if (state is RegisterLoadingState) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                        cubit.register(
                            email: email.text,
                            password: pass.text,
                            bio: "New Bio",
                            phone: phone.text,
                            name: name.text);
                      }),
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
                        text: "Login",
                        function: () {
                          navigatorPushReplacement(
                              context: context, widget: Login());
                        }),
                  ),
                ),
              ],
            ),
          ),
        )),
      );
    }, listener: (context, state) {
      if (state is RegisterSuccessState) {
        navigatorPushReplacement(context: context, widget: const Layout());
      }
    });
  }
}
