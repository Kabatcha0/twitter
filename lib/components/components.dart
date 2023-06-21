import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

void navigator({required BuildContext context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigatorPushReplacement(
    {required BuildContext context, required Widget widget}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

Widget button({required String text, required Function() function}) {
  return MaterialButton(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onPressed: function,
    child: Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
    ),
  );
}

Widget textFromField(
    {required String hint,
    required TextInputType textInputType,
    bool border = true,
    bool input = true,
    bool max = false,
    Function(String?)? onChange,
    required TextEditingController textEditingController}) {
  return TextFormField(
    maxLines: input ? 1 : 4,
    maxLength: max ? 280 : null,
    onChanged: onChange,
    controller: textEditingController,
    keyboardType: textInputType,
    decoration: InputDecoration(
      border: border ? null : InputBorder.none,
      contentPadding: const EdgeInsetsDirectional.only(start: 5),
      hintText: hint,
      hintStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    ),
  );
}

Widget profile({
  required String text,
  required String text1,
}) {
  return Row(
    children: [
      Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        text1,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      )
    ],
  );
}

Widget tweets(
    {required String photo,
    required String name,
    required String text,
    required int likes,
    required int retweet,
    required Function() retweetsFunc,
    required Function() likesFunc,
    required String date,
    required String image,
    bool interaction = true}) {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 4, end: 4),
    child: SizedBox(
      width: double.infinity,
      height: image == "" ? 130 : 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: photo != ""
                    ? NetworkImage(photo)
                    : const AssetImage("assets/placeholder.png")
                        as ImageProvider,
                radius: 25,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (text != "")
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 4),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(
            height: 8,
          ),
          if (image != "")
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              height: 220,
              child: image == ""
                  ? null
                  : Image.network(
                      image,
                      fit: BoxFit.fill,
                    ),
            ),
          const SizedBox(
            height: 2,
          ),
          if (interaction)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: likesFunc,
                  child: Row(
                    children: [
                      if (likes == 0)
                        const Icon(
                          EvaIcons.heartOutline,
                          color: Colors.black,
                          size: 30,
                        ),
                      if (likes > 0)
                        const Icon(
                          EvaIcons.heart,
                          color: Colors.red,
                          size: 30,
                        ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("$likes Likes")
                    ],
                  ),
                ),
                InkWell(
                  onTap: retweetsFunc,
                  child: Row(
                    children: [
                      const Icon(
                        EvaIcons.repeat,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("$retweet Retweets")
                    ],
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.grey[550],
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          if (!interaction)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Divider(
                color: Colors.black.withOpacity(0.7),
              ),
            )
        ],
      ),
    ),
  );
}

Widget notification({required String text, required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage("assets/placeholder.png"),
      ),
      Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
      ),
      Text(
        date,
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey[650],
            fontWeight: FontWeight.normal),
      ),
    ],
  );
}
