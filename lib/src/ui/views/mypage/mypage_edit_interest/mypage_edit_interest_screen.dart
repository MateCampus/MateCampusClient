import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/body.dart';

class MypageEditInterestScreen extends StatefulWidget {
  const MypageEditInterestScreen({Key? key}) : super(key: key);

  @override
  _MypageEditInterestScreenState createState() =>
      _MypageEditInterestScreenState();
}

class _MypageEditInterestScreenState extends State<MypageEditInterestScreen> {
  MypageViewModel vm = serviceLocator<MypageViewModel>();

  @override
  void initState() {
    vm.loadMyInterest();
    super.initState();
  }

  @override
  void dispose() {
    vm.resetInterests();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<MypageViewModel>.value(
      value: vm,
      child: Consumer<MypageViewModel>(builder: (context, vm, child) {
        return Scaffold(
          appBar: SubAppbar(
            titleText: '관심사 수정',
            isCenter: true,
          ),
          backgroundColor: Colors.white,
          body: Body(vm: vm),
        );
      }),
    );
  }
}
