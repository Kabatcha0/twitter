import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';
import 'package:twitter/modules/friends/friends.dart';

class Search extends StatelessWidget {
  TextEditingController search = TextEditingController();
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1.5)),
                    child: textFromField(
                        hint: "Search",
                        border: false,
                        onChange: (v) {
                          cubit.search(name: v!);
                        },
                        textInputType: TextInputType.name,
                        textEditingController: search),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (cubit.searchModel.isNotEmpty && search.text != "")
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                navigator(
                                    context: context,
                                    widget: Friend(
                                      index: index,
                                    ));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: cubit
                                                .searchModel[index].profile !=
                                            ""
                                        ? NetworkImage(
                                            cubit.searchModel[index].profile)
                                        : const AssetImage(
                                                "assets/placeholder.png")
                                            as ImageProvider,
                                    radius: 25,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    cubit.searchModel[index].name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: cubit.searchModel.length),
                  ))
              ],
            ),
          )),
        );
      },
    );
  }
}
