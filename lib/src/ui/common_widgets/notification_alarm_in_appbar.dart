import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';

import '../../business_logic/constants/size_constants.dart';

class NotificationAlarmInAppbar extends StatelessWidget {
  final Color? iconColor;
  final Color? badgeColor;
  const NotificationAlarmInAppbar({Key? key, this.iconColor, this.badgeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
    return homeViewModel.isNotificationExist
        ? badge.Badge(
            position: badge.BadgePosition.topEnd(top: 13, end: 13),
            badgeContent: null,
            badgeColor: badgeColor ?? Colors.red,
            padding: EdgeInsets.all(3),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
              icon: const Icon(
                FontAwesomeIcons.bell,
              ),
              iconSize: kAppBarIconSizeFA,
              color: iconColor,
            ),
          )
        : IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: const Icon(
              FontAwesomeIcons.bell,
            ),
            iconSize: kAppBarIconSizeFA,
            color: iconColor,
          );
  }
}
