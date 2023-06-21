import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/layout.dart';
import 'package:twitter/modules/splash.dart';
import 'package:twitter/shared/const.dart';
import 'package:twitter/shared/local/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  uid = CacheHelper.getData(key: "Uid");
  log("$uid");
  runApp(MyApp(check: uid));
}

class MyApp extends StatelessWidget {
  String? check;
  MyApp({super.key, required this.check});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: check == null || check == "" ? const Splash() : const Layout(),
      ),
    );
  }
}
