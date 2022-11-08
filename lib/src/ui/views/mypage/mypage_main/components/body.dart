import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/notification_alarm_in_appbar.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/additional_info_tab.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/menu_list.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/show_info.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/my_page_tabbar.dart';

class Body extends StatelessWidget {
  MypageViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: vm.myPageScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          centerTitle:false,
          title: Text(
                '\t내 정보',
                style: TextStyle(
                    fontFamily: 'Gmarket',
                    color: kAppBarTextColor,
                    fontSize: resizeFont(20),
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500),
              ),
              actions: [
                 IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(Icons.settings_outlined),
                  iconSize: kAppBarIconSizeG,
                  color: kAppBarIconColor,
                ),
                NotificationAlarmInAppbar(
                  iconColor: kAppBarIconColor,
                )
              ],
              elevation: 0.0,
              backgroundColor: kMainScreenBackgroundColor,
              pinned: false,
              floating: true,
              bottom: PreferredSize(child: ShowInfo(vm: vm), preferredSize:  Size.fromHeight(getProportionateScreenHeight(280)),),
        ),
        SliverPersistentHeader(delegate: MyPageTabbar(vm: vm)),
       
      ],
      // child: Column(
      //   children: [
      //     ShowInfo(vm: vm),
      //     AdditionalInfoTab(myInfo: vm.myInfo),
      //     const MenuList(),
      //   ],
      // ),
    );
  }
}
