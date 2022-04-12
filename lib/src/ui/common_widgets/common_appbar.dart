import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class CommonAppbar extends StatelessWidget with PreferredSizeWidget {
  const CommonAppbar(
      {Key? key,
      required this.appBar,
      this.title,
      this.bottom,
      this.height,
      this.titleSize})
      : super(key: key);
  final String? title;
  final PreferredSize? bottom;
  final AppBar appBar;
  final double? height;
  final double? titleSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "",
        style: TextStyle(
            color: Colors.white,
            fontSize: titleSize ?? 25,
            letterSpacing: 3,
            fontFamily: "SCDream4"),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [subColor, mainColor],
            stops: [0.5, 1.0],
          ),
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.people),
              color: Colors.white,
              onPressed: () {
                // 추후 반드시 삭제 (local db 확인 용)
              },
            ),
            SizedBox(width: getProportionateScreenWidth(2)),
            IconButton(
              icon: Icon(Icons.notifications_outlined),
              color: Colors.white,
              onPressed: () {},
            )
          ],
        ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.menu),
        color: Colors.white,
        onPressed: () {},
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? appBar.preferredSize.height);
}
