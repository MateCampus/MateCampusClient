import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_info/components/edit_image.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_info/components/edit_text.dart';

class Body extends StatefulWidget {
  MypageViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  String pickedImgPath = '';

  String get defaultNickname => widget.vm.myInfo.nickname;
  String get defaultIntroduction => widget.vm.myInfo.introduction ?? '';

  @override
  void initState() {
    super.initState();

    _nicknameController.text = defaultNickname;
    _introductionController.text = defaultIntroduction;

    //변화 감지 -> 버튼 활성화/비활성화 용도로 쓰임
    _nicknameController.addListener(() {
      setState(() {});
    });
    _introductionController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _introductionController.dispose();
    super.dispose();
  }

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
                EditText(
                    nicknameController: _nicknameController,
                    introductionController: _introductionController),
              ],
            ),
          ),
        ),
        DefaultShadowBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(10),
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(25)),
            child: (_nicknameController.text == defaultNickname &&
                    _introductionController.text == defaultIntroduction &&
                    pickedImgPath == '')
                ? DefaultBtn(
                    //비활성화 버튼
                    text: '설정 완료',
                    btnColor: Colors.grey.withOpacity(0.3),
                  )
                : DefaultBtn(
                    //활성화 버튼
                    text: '설정 완료',
                    press: () {
                      widget.vm.updateMyInfo(
                          context: context,
                          nickname: _nicknameController.text,
                          introduction: _introductionController.text,
                          imageUrl: pickedImgPath);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
