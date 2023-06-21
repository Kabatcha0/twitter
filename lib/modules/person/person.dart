import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/models/add_post.dart';
import 'package:twitter/modules/edit/edit.dart';
import 'package:twitter/modules/submit.dart';
import 'package:twitter/shared/const.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  int segementCurrent = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        if (cubit.getThePostsPerson.isEmpty) {
          cubit.getPostsPerson();
        }
        Widget segementValue() {
          if (segementCurrent == 0) {
            return Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
                  itemBuilder: (context, index) => tweets(
                      interaction: false,
                      date: cubit.getThePostsPerson[index].dateTime
                          .substring(0, 10),
                      likes: cubit.likesPerson.isNotEmpty
                          ? cubit.likesPerson[index]
                          : 0,
                      retweet: 0,
                      likesFunc: () {
                        cubit.addLikes(
                            id: cubit.idsPerson[index], index: index);
                      },
                      retweetsFunc: () {},
                      photo: cubit.getThePostsPerson[index].profile,
                      name: cubit.getThePostsPerson[index].name,
                      text: cubit.getThePostsPerson[index].text,
                      image: cubit.getThePostsPerson[index].image),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: cubit.getThePostsPerson.length),
            );
          } else if (segementCurrent == 1) {
            return Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
                  itemBuilder: (context, index) {
                    return tweets(
                        interaction: false,
                        date: cubit.getThePostsMedia[index].dateTime
                            .substring(0, 10),
                        likes: cubit.likesMedia.isNotEmpty
                            ? cubit.likesMedia[index]
                            : 0,
                        retweet: 0,
                        likesFunc: () {},
                        retweetsFunc: () {},
                        photo: cubit.getThePostsMedia[index].profile,
                        name: cubit.getThePostsMedia[index].name,
                        text: "",
                        image: cubit.getThePostsMedia[index].image);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: cubit.getThePostsMedia.length),
            );
          } else {
            return Center(
              child: Text("data2"),
            );
          }
        }

        return Scaffold(
          body: SafeArea(
              child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.blueAccent,
                          width: double.infinity,
                          height: double.infinity,
                          child: cubit.fileCover != null
                              ? Image.network(
                                  cubit.loginModel!.cover,
                                  fit: BoxFit.fitWidth,
                                )
                              : null,
                        ),
                        Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size: 32,
                              ),
                              itemBuilder: (_) {
                                return <PopupMenuItem>[
                                  PopupMenuItem(
                                    child: const Text(
                                      "Logout",
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                    onTap: () {
                                      uid = "";

                                      cubit.signOut(
                                          context: context,
                                          widget: const Submit());
                                    },
                                  )
                                ];
                              },
                            )),
                        Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Container(
                            transform: Matrix4.translationValues(10, 45, 0),
                            child: const CircleAvatar(
                              radius: 47,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Container(
                            transform: Matrix4.translationValues(12, 45, 0),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: cubit.file != null
                                  ? NetworkImage(
                                      cubit.loginModel!.profile,
                                    ) as ImageProvider
                                  : const AssetImage("assets/placeholder.png"),
                            ),
                          ),
                        )
                      ],
                    )),
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  navigator(
                                      context: context,
                                      widget: Edit(
                                          names: cubit.loginModel!.name,
                                          bios: cubit.loginModel!.bio));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  transform:
                                      Matrix4.translationValues(0, 0, 15),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: Colors.blueAccent)),
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 7),
                            child: Text(
                              cubit.loginModel!.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 7),
                            child: Text(
                              cubit.loginModel!.bio,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              profile(
                                  text: "${cubit.getThePostsPerson.length}",
                                  text1: "Posts"),
                              profile(
                                  text: cubit.getFollowers == null
                                      ? "0"
                                      : "${cubit.getFollowers!}",
                                  text1: "Following"),
                              profile(
                                  text: cubit.getFollowing == null
                                      ? "0"
                                      : "${cubit.getFollowing!}",
                                  text1: "Followers"),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 1, end: 1),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: CupertinoSegmentedControl<int>(
                                  padding: const EdgeInsets.all(10),
                                  selectedColor: Colors.blueAccent,
                                  unselectedColor: Colors.white,
                                  groupValue: segementCurrent,
                                  children: const {
                                    0: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                        "Tweets",
                                        style: TextStyle(
                                            fontSize: 17, package: "s"),
                                      ),
                                    ),
                                    1: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text("Media",
                                          style: TextStyle(fontSize: 17)),
                                    ),
                                    2: Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Text("Likes",
                                          style: TextStyle(fontSize: 17)),
                                    )
                                  },
                                  onValueChanged: (i) {
                                    setState(() {
                                      segementCurrent = i;
                                    });
                                  }),
                            ),
                          ),
                          if (cubit.getThePostsPerson.isEmpty) Container(),
                          if (cubit.getThePostsPerson.isNotEmpty)
                            segementValue()
                        ],
                      ),
                    )),
              ],
            ),
          )),
        );
      },
    );
  }
}
