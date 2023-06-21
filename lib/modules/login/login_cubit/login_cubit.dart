// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:twitter/models/login_model.dart';
// import 'package:twitter/modules/login/login_cubit/login_states.dart';
// import 'package:twitter/shared/const.dart';

// class LogInCubit extends Cubit<LogInStates> {
//   LogInCubit() : super(LogInInitialState());
//   static LogInCubit get(context) => BlocProvider.of(context);
 

//   void logIn({
//     required String email,
//     required String password,
//   }) {
//     emit(LogInLoadingState());

//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//       log(uid);
//       uid = value.user!.uid;
//       log(uid);
//       emit(LogInSuccessState());
//     }).catchError((e) {
//       if (e is FirebaseAuthException) {
//         emit(LogInErrorState());
//       }
//     });
//   }
// }
