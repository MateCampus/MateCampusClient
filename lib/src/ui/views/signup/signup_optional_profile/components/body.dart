import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_disable_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';

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
                children: [],
              ),
            ),
          ),
        ),
        DefaultShadowBox(
          child: Padding(
            padding: defaultPadding,
            child: (vm.isValidId && vm.isValidPW) //여기 바꾸기
                ? DefaultBtn(
                    //여기를 완료로 바꾸고
                    text: '다음',
                    press: () {
                      Navigator.pushNamed(context, '');
                    },
                  )
                : const DefaultDisalbeBtn(
                    text: '다음'), //비활성화 버튼이 아니라 건너뛰기 버튼으로 해야할듯?
          ),
        ),
      ],
    );
  }
}
