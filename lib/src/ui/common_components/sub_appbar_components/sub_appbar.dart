import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';

class SubAppbar extends StatelessWidget with PreferredSizeWidget {
  final String? titleText;
  final List<Widget>? actions;
  final GestureTapCallback? leadingOnPress;
  final Color? backgroundColor;
  final bool? isCenter;
  final PreferredSize? bottom;
  final double? toolbarHeight;

  SubAppbar(
      {Key? key,
      this.titleText,
      this.actions,
      this.leadingOnPress,
      this.backgroundColor,
      this.isCenter,
      this.bottom,
      this.toolbarHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.chevron_back),
        color: Colors.black,
        onPressed: leadingOnPress ??
            () {
              Navigator.of(context).pop();
            },
      ),
      title: Text(
        titleText ?? '',
        style: TextStyle(
            fontFamily: 'Gmarket',
            color: Colors.black,
            fontWeight: FontWeight.w700),
      ),
      centerTitle: isCenter ?? false,
      actions: actions,
      bottom: bottom,
      elevation: 0,
      backgroundColor: backgroundColor ?? kSubScreenBackgroundColor,
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
