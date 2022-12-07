import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/body.dart';

class SignUpCollegeScreen extends StatefulWidget {
  const SignUpCollegeScreen({Key? key}) : super(key: key);

  @override
  _SignUpCollegeScreenState createState() => _SignUpCollegeScreenState();
}

class _SignUpCollegeScreenState extends State<SignUpCollegeScreen> {
  SignUpViewModel vm = serviceLocator<SignUpViewModel>();

  @override
  void initState() {
    super.initState();
    vm.setCollegeList();
    vm.collegeController.addListener(() {
      vm.searchCollege();
    });
   
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<SignUpViewModel>.value(
      value: vm,
      child: Consumer<SignUpViewModel>(builder: (context, vm, child) {
        return GestureDetector(
          onTap: () =>
              FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
          child: Scaffold(
            appBar: SubAppbar(
              titleText: '학교 정보 입력',
              isCenter: true,
              leadingOnPress: () {
                //혹시 overlay가 open된 채로 뒤로가기를 눌렀을 때 remove
                vm.removeCollegeOverlay();
                vm.removeMajorOverlay();
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: kSubScreenBackgroundColor,
            body: Body(vm: vm),
          ),
        );
      }),
    );
  }
}
