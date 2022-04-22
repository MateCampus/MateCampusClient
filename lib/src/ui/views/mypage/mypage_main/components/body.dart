import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/additional_info_tab.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/menu_list.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/show_info.dart';

class Body extends StatelessWidget {
  MypageViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ShowInfo(vm: vm),
          AdditionalInfoTab(myInfo: vm.myInfo),
          const MenuList(),
        ],
      ),
    );
  }
}
