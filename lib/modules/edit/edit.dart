import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/layout/layout.dart';

class Edit extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController bio = TextEditingController();
  String? names;
  String? bios;
  Edit({required this.bios, required this.names});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is LayoutGetUserSuccessState) {
          navigator(context: context, widget: const Layout());
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          body: SafeArea(
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
                        child: cubit.fileCover == null
                            ? null
                            : Image.file(
                                cubit.fileCover!,
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 23,
                            )),
                      ),
                      Align(
                          alignment: AlignmentDirectional.center,
                          child: InkWell(
                            onTap: () {
                              if (cubit.fileCover != null) {
                                cubit.deleteImageCover(photo: cubit.fileCover!);
                              }
                              cubit.imagePickerCover();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Change Cover Photo",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )
                              ],
                            ),
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
                        child: InkWell(
                          onTap: () {
                            if (cubit.file != null) {
                              cubit.deleteImageProfile(photo: cubit.file!);
                            }
                            cubit.imagePickerProfile();
                          },
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            transform: Matrix4.translationValues(7, 45, 0),
                            width: 100,
                            height: 100,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: cubit.file == null
                                      ? Image.asset(
                                          "assets/placeholder.png",
                                        )
                                      : Image.file(
                                          cubit.file!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                const Icon(
                                  Icons.camera_alt,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 50, start: 10, end: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              cubit.changeNameAndBio(
                                  name: name.text, bio: bio.text);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              transform: Matrix4.translationValues(0, 0, 15),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.blueAccent)),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        "Name",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      textFromField(
                          hint: names!,
                          textInputType: TextInputType.name,
                          textEditingController: name),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        "Bio",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      textFromField(
                          hint: bios!,
                          textInputType: TextInputType.name,
                          textEditingController: bio),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is LayoutGetUserLoadingState) ...[
                        const LinearProgressIndicator(
                          color: Colors.blue,
                        )
                      ]
                    ],
                  ),
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
