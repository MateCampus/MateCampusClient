import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class TextInputSpace extends StatefulWidget {
  PostCreateScreenViewModel vm;
  TextInputSpace({Key? key, required this.vm}) : super(key: key);

  @override
  _TextInputSpaceState createState() => _TextInputSpaceState();
}

class _TextInputSpaceState extends State<TextInputSpace> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '내용',
          style: kLabelTextStyle,
        ),
        const VerticalSpacing(of: 10),
        Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              focusNode: widget.vm.postFocusNode,
              textInputAction: TextInputAction.newline,
              controller: widget.vm.bodyTextController,
              style: TextStyle(fontSize: kTextFieldInnerFontSize),
              // style: TextStyle(fontSize: 150), //테스트용
              maxLength: 250,
              maxLines: 8,
              minLines: 8, //이걸로 사이즈 조절
              decoration: InputDecoration(
                hintText: "무슨 이야기를 나누고 싶으세요?",
                hintStyle: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: kTextFieldInnerFontSize),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffe5e5ec)),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffe5e5ec)),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffe5e5ec)),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
