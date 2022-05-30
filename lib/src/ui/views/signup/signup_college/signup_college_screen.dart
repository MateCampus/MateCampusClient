import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/body.dart';

class SignUpCollegeScreen extends StatefulWidget {
  const SignUpCollegeScreen({Key? key}) : super(key: key);

  @override
  _SignUpCollegeScreenState createState() => _SignUpCollegeScreenState();
}

class _SignUpCollegeScreenState extends State<SignUpCollegeScreen> {
  SignUpViewModel vm = serviceLocator<SignUpViewModel>();

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
            appBar: PreferredSize(
              //이렇게 해둔곳이 post detail 이랑 voice detail두개인데 나머지도 다 통일해야하는지 아직 안정함.
              preferredSize: Size.fromHeight(getProportionateScreenHeight(30)),
              child: AppBar(
                title: Text(
                  '학교 정보 입력',
                  style: TextStyle(color: Colors.black),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.chevron_left_outlined),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
            ),
            backgroundColor: Colors.white,
            body: Body(vm: vm),
          ),
        );
      }),
    );
  }
}
