import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/modules/edit/edit.dart';
import 'package:twitter/modules/submit.dart';
import 'package:twitter/shared/const.dart';

class Friend extends StatefulWidget {
  int index;
  Friend({required this.index});

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  int segementCurrent = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
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
                          child: cubit.searchModel[widget.index].cover != ""
                              ? Image.network(
                                  cubit.searchModel[widget.index].cover,
                                  fit: BoxFit.fitWidth,
                                )
                              : null,
                        ),
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
                              backgroundImage: cubit
                                          .searchModel[widget.index].profile !=
                                      ""
                                  ? NetworkImage(
                                      cubit.searchModel[widget.index].profile,
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
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  if (cubit.checkFollowers.contains(
                                    cubit.searchModel[widget.index].uid,
                                  )) {
                                    cubit.changeDeleteFollow(
                                        followers:
                                            cubit.searchModel[widget.index].uid,
                                        uid: uid!);
                                  } else {
                                    cubit.changeAddFollow(
                                        followers:
                                            cubit.searchModel[widget.index].uid,
                                        uid: uid!);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  transform:
                                      Matrix4.translationValues(0, 0, 15),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: state
                                                  is LayoutAddFollowersLoadingState ||
                                              state
                                                  is LayoutDeleteFollowersLoadingState ||
                                              cubit.checkFollowers.contains(
                                                cubit.searchModel[widget.index]
                                                    .uid,
                                              )
                                          ? Border.all(color: Colors.blueAccent)
                                          : Border.all(color: Colors.blue)),
                                  child: state
                                              is LayoutAddFollowersLoadingState ||
                                          state
                                              is LayoutDeleteFollowersLoadingState ||
                                          cubit.checkFollowers.contains(
                                            cubit.searchModel[widget.index].uid,
                                          )
                                      ? const Text(
                                          "Following",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 16),
                                        )
                                      : const Text(
                                          "Follow",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 16),
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
                              cubit.searchModel[widget.index].name,
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
                              cubit.searchModel[widget.index].bio,
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
                              profile(text: "0", text1: "Posts"),
                              profile(
                                  text: cubit.getFollowing == null
                                      ? "0"
                                      : "${cubit.getFollowing!}",
                                  text1: "Following"),
                              profile(
                                  text: cubit.getFollowers == null
                                      ? "0"
                                      : "${cubit.getFollowers!}",
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

  Widget segementValue() {
    if (segementCurrent == 0) {
      return Center(
        child: Text("data"),
      );
    } else if (segementCurrent == 1) {
      return Center(
        child: Text("data1"),
      );
    } else {
      return Center(
        child: Text("data2"),
      );
    }
  }
}
