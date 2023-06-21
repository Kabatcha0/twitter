import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/layout/layout.dart';

class AddTweet extends StatelessWidget {
  TextEditingController tweet = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is GetPostSuccessState) {
          navigatorPushReplacement(context: context, widget: const Layout());
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        cubit.post = null;
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                textFromField(
                    input: false,
                    hint: "add tweet",
                    max: true,
                    textInputType: TextInputType.emailAddress,
                    textEditingController: tweet),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      cubit.imagePost();
                    },
                    child: const Icon(Icons.camera_alt_outlined, size: 100)),
                const SizedBox(
                  height: 10,
                ),
                if (cubit.post != null)
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 200,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: cubit.post == null
                        ? null
                        : Image.file(
                            cubit.post!,
                            fit: BoxFit.cover,
                          ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (state is AddPostLoadingState) ...[
                  const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 40,
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
                        text: "Tweet",
                        function: () {
                          cubit.putPhotoPost(
                              name: cubit.loginModel!.name,
                              profile: cubit.loginModel!.profile,
                              text: tweet.text,
                              dateTime: DateTime.now().toString());
                        }),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
