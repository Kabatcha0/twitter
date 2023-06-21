import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          if (cubit.getFollowers == null &&
              cubit.getFollowing == null &&
              cubit.loginModel == null) {
            cubit.getUser();
            cubit.following();
            cubit.getFollow();
          }

          return Scaffold(
            body: cubit.loginModel == null &&
                    cubit.getFollowers == null &&
                    cubit.getFollowing == null
                ? Container()
                : cubit.widget[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (int i) {
                  cubit.index(i);
                },
                currentIndex: cubit.currentIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.white,
                elevation: 0,
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        EvaIcons.home,
                        size: 26,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        EvaIcons.search,
                        size: 26,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        EvaIcons.bell,
                        size: 26,
                      ),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        EvaIcons.person,
                        size: 26,
                      ),
                      label: ""),
                ]),
          );
        },
        listener: (context, state) {});
  }
}
