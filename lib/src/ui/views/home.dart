import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/voice_room_create_bottom_sheet_component/voice_room_create_bottom_sheet.dart';
import 'package:zamongcampus/src/ui/common_widgets/chat_alarm_icon_bottom_navigation_bar.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageStorageBucket bucket = PageStorageBucket();
  HomeViewModel vm = serviceLocator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);

    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<HomeViewModel>(builder: (context, vm, child) {
          return Scaffold(
            body: PageStorage(
              child: vm.currentScreen,
              bucket: bucket,
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                      onPressed: () {
                        vm.changeCurrentIndex(0);
                      },
                      child: vm.currentTab == 0
                          ? _activeIcon(
                              CupertinoIcons.square_favorites_alt_fill, '피드')
                          : _deactiveIcon(
                              CupertinoIcons.square_favorites_alt, '피드')),
                  MaterialButton(
                      onPressed: () {
                        vm.changeCurrentIndex(1);
                      },
                      child: vm.currentTab == 1
                          ? ChatAlarmIconBottomNavigationBar(
                              widget: _activeIcon(
                                  CupertinoIcons.ellipses_bubble_fill, '채팅'))
                          : ChatAlarmIconBottomNavigationBar(
                              widget: _deactiveIcon(
                                  CupertinoIcons.ellipses_bubble, '채팅'))),
                  MaterialButton(
                      onPressed: () {
                        vm.changeCurrentIndex(2);
                      },
                      child: vm.currentTab == 2
                          ? _activeIcon(CupertinoIcons.person_fill, '프로필')
                          : _deactiveIcon(CupertinoIcons.person, '프로필'))
                ],
              ),
            ),
          );
        }));
  }

  Widget _activeIcon(IconData icon, String name) {
    return SizedBox(
      height: getProportionateScreenHeight(56),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: kBottomNavigationBarIconSize,
            color: kMainColor,
          ),
          const VerticalSpacing(of: 4),
          Text(
            name,
            style: kBottomNavigationBarTextStyleActive,
          )
        ],
      ),
    );
  }

  Widget _deactiveIcon(IconData icon, String name) {
    return SizedBox(
      height: getProportionateScreenHeight(56),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: kBottomNavigationBarIconSize,
            color: Colors.black54,
          ),
          const VerticalSpacing(of: 4),
          Text(
            name,
            style: kBottomNavigationBarTextStyleDeactive,
          )
        ],
      ),
    );
  }
}
