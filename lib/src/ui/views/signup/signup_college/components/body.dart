import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/certification.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/select_college.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/select_major.dart';

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
                  SelectCollege(vm: vm),
                  SelectMajor(vm: vm),
                  Certification(vm: vm)
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
            child: (vm.selectedCollege != '' &&
                    vm.selectedMajor != '' &&
                    vm.studentIdImgPath != '')
                ? DefaultBtn(
                    text: '다음',
                    press: () {
                      Navigator.pushNamed(context, '/signUpAuthentication');
                    },
                  )
                : const DisabledDefaultBtn(text: '다음'),
          ),
        ),
      ],
    );
  }
}
