import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
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
        // SafeArea(
        //   child: (widget.vm.isValidNickname ||
        //           widget.vm.isValidIntroduction ||
        //           widget.vm.changedProfileImgPath.isNotEmpty)
        //       ? //활성화 버튼
        //       _editInfoBtn()
        //       : //비활성화 버튼
        //       _editInfoBtnDisable(),
        // ),
      ],
    );
  }
}
