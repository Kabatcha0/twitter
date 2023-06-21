import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter/components/components.dart';
import 'package:twitter/layout/cubit/cubit.dart';
import 'package:twitter/layout/cubit/states.dart';

class Bell extends StatelessWidget {
  const Bell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          body: SafeArea(
              child: cubit.notificationsModel != null
                  ? SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) => notification(
                                text: cubit.notificationsModel[index].text,
                                date: cubit.notificationsModel[index].timeStamp
                                    .substring(0, 10)),
                            separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: Divider(
                                    color: Colors.grey[650],
                                  ),
                                ),
                            itemCount: cubit.notificationsModel.length),
                      ),
                    )
                  : Container()),
        );
      },
    );
  }
}
