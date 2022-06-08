import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_info/components/edit_image.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_info/components/edit_text.dart';

class Body extends StatefulWidget {
  MypageViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                EditImage(
                  vm: widget.vm,
                ),
                EditText(vm: widget.vm)
              ],
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
              child: (widget.vm.isValidNickname ||
                      widget.vm.isValidIntroduction ||
                      widget.vm.changedProfileImgPath.isNotEmpty)
                  ? //활성화 버튼
                  DefaultBtn(
                      text: '설정 완료',
                      press: () {
                        widget.vm.updateMyInfo(context: context);
                      },
                    )
                  : //비활성화 버튼
                  const DisabledDefaultBtn(text: '설정 완료')),
        ),
      ],
    );
  }
}
