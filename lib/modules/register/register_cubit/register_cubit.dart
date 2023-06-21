// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:twitter/models/login_model.dart';
// import 'package:twitter/modules/register/register_cubit/register_states.dart';
// import 'package:twitter/shared/const.dart';

// class RegisterCubit extends Cubit<RegisterStates> {
//   RegisterCubit() : super(RegisterInitialState());
//   static RegisterCubit get(context) => BlocProvider.of(context);
//   void register({
//     required String email,
//     required String password,
//     required String phone,
//     required String name,
//     required String bio,
//   }) {
//     emit(RegisterLoadingState());

//     FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//       uid = value.user!.uid;
//       storeRegister(
//           name: name, phone: phone, email: email, pass: password, bio: bio);
//     }).catchError((e) {
//       if (e is FirebaseAuthException) {
//         emit(RegisterErrorState());
//       }
//     });
//   }



//   void storeRegister({
//     required String name,
//     required String phone,
//     required String email,
//     required String pass,
//     required String bio,
//   }) {
//     LoginModel loginModel = LoginModel(
//         email: email,
//         name: name,
//         bio: bio,
//         cover: "",
//         pass: pass,
//         profile: "",
//         uid: uid);
//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(uid)
//         .set(loginModel.toJson(
//             email: email,
//             name: name,
//             bio: bio,
//             cover: "",
//             pass: pass,
//             uid: uid,
//             profile: ""))
//         .then((value) {
//       emit(RegisterSuccessState());
//     }).catchError((e) {});
//   }
// }
