import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/edit_interest.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/fixed_text.dart';

class Body extends StatelessWidget {
  MypageViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [const FixedText(), Expanded(child: EditInterest(vm: vm))],
    );
  }
}
