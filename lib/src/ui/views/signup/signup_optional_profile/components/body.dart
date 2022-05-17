import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_optional_profile/components/select_profile_image.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_optional_profile/components/user_introduce_input.dart';

class Body extends StatelessWidget {
  final SignUpViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectProfileImage(vm: vm),
                  UserIntroduceInput(vm: vm)
                ],
              ),
            ),
          ),
        ),
        DefaultShadowBox(
          child: Padding(
              padding: defaultPadding,
              child: (vm.userImgPath != '' &&
                      vm.userIntroduceController.text != '')
                  ? DefaultBtn(
                      text: '설정 완료',
                      press: () {
                        vm.createUser();
                        Navigator.pushNamed(context, '/login');
                      },
                    )
                  : DefaultBtn(
                      text: '건너뛰기',
                      btnColor: Colors.grey.withOpacity(0.3),
                      press: () {
                        vm.createUser();
                        Navigator.pushNamed(context, '/login');
                      },
                    )),
        ),
      ],
    );
  }
}
