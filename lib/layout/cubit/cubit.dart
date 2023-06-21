import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/models/add_post.dart';
import 'package:twitter/models/login_model.dart';
import 'package:twitter/models/notifications_model.dart';
import 'package:twitter/models/search_model.dart';
import 'package:twitter/modules/bell/bell.dart';
import 'package:twitter/modules/home/home.dart';
import 'package:twitter/modules/person/person.dart';
import 'package:twitter/modules/search/search.dart';
import 'package:twitter/shared/const.dart';
import 'package:twitter/shared/local/local.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void index(int i) {
    currentIndex = i;
    emit(LayoutIndexState());
  }

  List<Widget> widget = [const Home(), Search(), const Bell(), const Person()];
  void signOut({required BuildContext context, required Widget widget}) {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.deleteData(key: "Uid");
      navigatorPushReplacement(context: context, widget: widget);
    });
  }

  LoginModel? loginModel;
  void getUser() {
    emit(LayoutGetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
      loginModel = LoginModel.fromJson(value.data()!);
      emit(LayoutGetUserSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  void logIn({
    required String email,
    required String password,
  }) {
    emit(LogInLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uid = value.user!.uid;
      CacheHelper.setData(key: "Uid", value: uid!);
      getUser();

      emit(LogInSuccessState());
    }).catchError((e) {
      if (e is FirebaseAuthException) {
        emit(LogInErrorState());
      }
    });
  }

  void register({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String bio,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uid = value.user!.uid;
      CacheHelper.setData(key: "Uid", value: uid!);
      storeRegister(
          name: name, phone: phone, email: email, pass: password, bio: bio);
    }).catchError((e) {
      if (e is FirebaseAuthException) {
        emit(RegisterErrorState());
      }
    });
  }

  void storeRegister({
    required String name,
    required String phone,
    required String email,
    required String pass,
    required String bio,
  }) {
    LoginModel loginModel = LoginModel(
        email: email,
        name: name,
        bio: bio,
        cover: "",
        pass: pass,
        profile: "",
        uid: uid!);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(loginModel.toJson(
            email: email,
            name: name,
            bio: bio,
            cover: "",
            pass: pass,
            uid: uid!,
            profile: ""))
        .then((value) {
      getUser();
      emit(RegisterSuccessState());
    }).catchError((e) {});
  }

  File? file;
  void imagePickerProfile() {
    // ignore: invalid_use_of_visible_for_testing_member
    ImagePicker.platform
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        file = File(value.path);
        putPhotoProfile();
        emit(LayoutImagePickerProfileSuccessState());
      } else {
        return null;
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  File? fileCover;
  void imagePickerCover() {
    // ignore: invalid_use_of_visible_for_testing_member
    ImagePicker.platform
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        fileCover = File(value.path);
        putPhotoCover();
        emit(LayoutImagePickerCoverSuccessState());
      } else {
        return null;
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  void putPhotoProfile() {
    FirebaseStorage.instance
        .ref()
        .child("profile/${Uri.file(file!.path).pathSegments.last}")
        .putFile(file!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        changeProfilePic(
          profile: value,
        );
      }).catchError((e) {
        log(e.toString());
      });
    }).catchError((e) {
      log(e.toString());
    });
  }

  void changeProfilePic({required String profile}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"profile": profile}).then((value) {
      // getUser();
      emit(LayoutChangeProfileSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  void changeNameAndBio({
    required String name,
    required String bio,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"name": name, "bio": bio}).then((value) {
      getUser();
      emit(LayoutChangeNameAndBioSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  void putPhotoCover() {
    FirebaseStorage.instance
        .ref()
        .child("cover/${Uri.file(fileCover!.path).pathSegments.last}")
        .putFile(fileCover!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        changeCoverPic(cover: value);
      }).catchError((e) {
        log(e.toString());
      });
    }).catchError((e) {
      log(e.toString());
    });
  }

  void changeCoverPic({required String cover}) {
    FirebaseFirestore.instance.collection("users").doc(uid).update({
      "cover": cover,
    }).then((value) {
      // getUser();
      emit(LayoutChangeCoverSuccessState());
    });
  }

  void deleteImageCover({required File photo}) {
    FirebaseStorage.instance.ref().child("cover/$photo").delete().then((value) {
      emit(LayoutDeleteCoverSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  void deleteImageProfile({required File photo}) {
    FirebaseStorage.instance
        .ref()
        .child("profile/$photo")
        .delete()
        .then((value) {
      emit(LayoutDeleteProfileSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

//follow
  List<SearchModel> searchModel = [];
  void search({required String name}) {
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      searchModel = [];
      for (var element in event.docs) {
        if (element.data()["uid"] != uid) {
          if (element.data()["name"].contains(name)) {
            searchModel.add(SearchModel.fromJson(element.data()));
          }
        }
        emit(LayoutSearchSuccessState());
      }
    });
  }

  List<String> checkFollowers = [];
  void changeAddFollow({required String followers, required String uid}) {
    emit(LayoutAddFollowersLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("followers")
        .add({"followers": followers}).then((value) {
      checkFollowers.add(followers);
      changeAddFollowInUid(followers: followers, uid: uid);
      emit(LayoutAddFollowersSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  List checkFollowing = [];
  void changeAddFollowInUid({required String followers, required String uid}) {
    emit(LayoutAddFollowersInIdLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(followers)
        .collection("following")
        .add({"following": uid}).then((value) {
      checkFollowing.add(followers);
      getFollow();
      following();
      emit(LayoutAddFollowersInIdSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  void changeDeleteFollow({required String followers, required String uid}) {
    emit(LayoutDeleteFollowersLoadingState());

    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("followers")
        .get()
        .then((value) {
      for (var e in value.docs) {
        log(e.id);
        if (e.data()["followers"] == followers) {
          checkFollowers.remove(followers);
          FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .collection("followers")
              .doc(e.id)
              .delete()
              .then((value) {
            changeDeleteFollowInUid(followers: followers, uid: uid);
            emit(LayoutDeleteFollowersSuccessState());
          }).catchError((e) {
            log(e.toString());
          });
        }
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  void changeDeleteFollowInUid(
      {required String followers, required String uid}) {
    emit(LayoutDeleteFollowersInIdLoadingState());

    FirebaseFirestore.instance
        .collection("users")
        .doc(followers)
        .collection("following")
        .get()
        .then((value) {
      for (var e in value.docs) {
        log(e.id);
        if (e.data()["following"] == uid) {
          checkFollowers.remove(followers);
          FirebaseFirestore.instance
              .collection("users")
              .doc(followers)
              .collection("following")
              .doc(e.id)
              .delete()
              .then((value) {
            getFollow();
            following();
            emit(LayoutDeleteFollowersInIdSuccessState());
          }).catchError((e) {
            log(e.toString());
          });
        }
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  int? getFollowing;

  void following() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("following")
        .get()
        .then((value) {
      getFollowing = value.docs.length;
      emit(LayoutGetFollowingSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  int? getFollowers;
  void getFollow() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("followers")
        .get()
        .then((value) {
      getFollowers = value.docs.length;
      emit(LayoutGetFollowersSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  File? post;
  void imagePost() {
    // ignore: invalid_use_of_visible_for_testing_member
    ImagePicker.platform
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        post = File(value.path);
        emit(LayoutImagePickerPostSuccessState());
      } else {
        return null;
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  List<int> likesHome = [];
  void putPhotoPost({
    required String text,
    required String dateTime,
    required String name,
    required String profile,
  }) {
    emit(AddPostLoadingState());
    if (post != null) {
      FirebaseStorage.instance
          .ref()
          .child("posts/${Uri.file(post!.path).pathSegments.last}")
          .putFile(post!)
          .then((v) {
        v.ref.getDownloadURL().then((value) {
          addPost(
              likes: likesHome,
              dateTime: dateTime,
              image: value,
              text: text,
              name: name,
              profile: profile);
        }).catchError((e) {
          log(e.toString());
        });
      }).catchError((e) {
        log(e.toString());
      });
    } else {
      addPost(
          dateTime: dateTime,
          text: text,
          name: name,
          profile: profile,
          likes: []);
      return;
    }
  }

  void addPost(
      {required String dateTime,
      String? image,
      required String text,
      required String name,
      required String profile,
      required List likes}) {
    AddPosts addPosts = AddPosts(
      dateTime: dateTime,
      image: image ?? "",
      text: text,
      uid: uid!,
      name: name,
      profile: profile,
      // likes: likes
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(addPosts.toJson(
            // likes: likes,
            name: name,
            profile: profile,
            uid: uid!,
            text: text,
            image: image ?? "",
            dateTime: dateTime))
        .then((value) {
      addNotifications(
          id: value.id, timeStamp: dateTime, text: "ur friend add post");
      getPostsHome();
      getPostsPerson();
      emit(AddPostSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }

  List<AddPosts> getThePosts = [];
  List<AddPosts> getThePostsPerson = [];
  List<AddPosts> getThePostsMedia = [];
  List<String> idsHome = [];
  List<String> idsPerson = [];
  List<int> likesPerson = [];
  List<int> likesMedia = [];
  void getPostsHome() {
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .listen((value) {
      getThePosts = [];
      idsHome = [];

      for (var element in value.docs) {
        element.reference.collection("likes").snapshots().listen((value) {
          likesHome.add(value.docs.length);
          idsHome.add(element.id);
          emit(GetPostSuccessState());
        });
        getThePosts.add(AddPosts.fromJson(element.data()));
        emit(GetPostSuccessState());
      }
    });
  }

  void getPostsPerson() {
    // emit(GetPostLoadingState());

    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .listen((value) {
      getThePostsPerson = [];
      getThePostsMedia = [];
      for (var element in value.docs) {
        if (element.data()["uid"] == uid) {
          element.reference.collection("likes").snapshots().listen((value) {
            idsPerson.add(element.id);
            likesPerson.add(value.docs.length);
            if (element.data()["image"] != "") {
              likesMedia.add(value.docs.length);
              emit(GetPostPersonSuccessState());
            }
          });
          if (element.data()["image"] != "") {
            getThePostsMedia.add(AddPosts.fromJson(element.data()));
            emit(GetPostPersonSuccessState());
          }
          getThePostsPerson.add(AddPosts.fromJson(element.data()));
          emit(GetPostPersonSuccessState());
        }
      }
    });
  }

  void deleteLikes({required String id, required int index}) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("likes")
        .doc(uid)
        .delete()
        .then((value) {
      if (likesHome[index] < 0) {
        likesHome[index] = likesHome[index] - 1;

        emit(LayoutDeleteLikesSuccessState());
      }
    }).catchError((e) {
      log(e.toString());
    });
  }

  void addLikes({required String id, required int index}) {
    if (idsHome.contains(id) && likesHome[index] > 0) {
      deleteLikes(id: id, index: index);
      emit(LayoutAddLikesSuccessState());
    } else {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(id)
          .collection("likes")
          .doc(uid)
          .set({"likes": true}).then((value) {
        emit(LayoutAddLikesSuccessState());
      }).catchError((e) {
        log(e.toString());
      });
    }
  }

  List<NotificationsModel> notificationsModel = [];
  void getNotification({
    required String id,
    required String timeStamp,
    required String text,
  }) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("Notifications")
        .doc(uid)
        .get()
        .then((value) {
      if (value.data()!["uid"] != uid) {
        notificationsModel.add(NotificationsModel.fromJson(value.data()!));
        emit(LayoutGetNotificationsSuccessState());
      }
    });
  }

  void addNotifications({
    required String id,
    required String timeStamp,
    required String text,
  }) {
    NotificationsModel notificationsModel =
        NotificationsModel(id: id, text: text, timeStamp: timeStamp, uid: uid!);
    FirebaseFirestore.instance
        .collection("posts")
        .doc(id)
        .collection("Notifications")
        .doc(uid)
        .set(notificationsModel.toMap(
            timeStamp: timeStamp, id: id, text: text, uid: uid!))
        .then((value) {
      getNotification(id: id, timeStamp: timeStamp, text: text);
      emit(LayoutAddNotificationsSuccessState());
    }).catchError((e) {
      log(e.toString());
    });
  }
}
