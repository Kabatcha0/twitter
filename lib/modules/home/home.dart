import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/modules/add_tweet/add_tweet.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        if (cubit.getThePosts.isEmpty) {
          cubit.getPostsHome();
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueAccent,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            title: const Text(
              "Posts",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
              ),
            ),
          ),
          body: SafeArea(
            child: cubit.getThePosts.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => tweets(
                              date: cubit.getThePosts[index].dateTime
                                  .substring(0, 10),
                              likes: cubit.likesHome.isNotEmpty
                                  ? cubit.likesHome[index]
                                  : 0,
                              retweet: 0,
                              likesFunc: () {
                                cubit.addLikes(
                                    id: cubit.idsHome[index], index: index);
                              },
                              retweetsFunc: () {},
                              photo: cubit.getThePosts[index].profile,
                              name: cubit.getThePosts[index].name,
                              text: cubit.getThePosts[index].text,
                              image: cubit.getThePosts[index].image,
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: cubit.getThePosts.length),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigator(context: context, widget: AddTweet());
            },
            backgroundColor: Colors.white,
            child: Image.asset("assets/tweet.png"),
          ),
        );
      },
    );
  }
}
