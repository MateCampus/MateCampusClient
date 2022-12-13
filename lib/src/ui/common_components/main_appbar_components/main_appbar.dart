import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions;
  final PreferredSize? bottom;
  final double? toolbarHeight;
  const MainAppBar(
      {Key? key,
      required this.titleText,
      this.actions,
      this.bottom,
      this.toolbarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '\t$titleText',
        style: TextStyle(
            fontFamily: 'Pretendard',
            color: kAppBarTextColor,
            fontSize: resizeFont(20),
            // letterSpacing: 2,
            fontWeight: FontWeight.w700),
      ),
      centerTitle: false,
      actions: actions,
      bottom: bottom,
      elevation: 0,
      backgroundColor: kMainScreenBackgroundColor,
    );
  }

  @override
  Size get preferredSize =>
      _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
