import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/edit_interest.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/fixed_text.dart';

class Body extends StatelessWidget {
  MypageViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return vm.busy
        ? const IsLoading()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FixedText(),
              Expanded(child: EditInterest(vm: vm)),
              SafeArea(
                  child: BottomFixedBtnDecoBox(
                      child: DefaultBtn(
                text: vm.selectedInterestCodes.length.toString() + '개 선택됨',
                press: () {
                  vm.updateInterests(context: context);
                },
              )))
            ],
          );
  }
}
