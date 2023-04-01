import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class ChatAlarmIconBottomNavigationBar extends StatelessWidget {
  final Widget widget;
  const ChatAlarmIconBottomNavigationBar({Key? key, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
    if (homeViewModel.unreadChatMessageCount == 0) {
      return widget;
    } else if (homeViewModel.unreadChatMessageCount >= 0) {
      return badge.Badge(
        position: badge.BadgePosition.topEnd(
            top: -getProportionateScreenHeight(2),
            end: -getProportionateScreenWidth(5)),
        badgeContent: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            homeViewModel.unreadChatMessageCount.toString(),
            style: TextStyle(color: Colors.white, fontSize: resizeFont(12)),
          ),
        ),
        badgeColor: Colors.red,
        padding: const EdgeInsets.all(3),
        child: widget,
      );
    } else {
      return widget;
    }
  }
}
