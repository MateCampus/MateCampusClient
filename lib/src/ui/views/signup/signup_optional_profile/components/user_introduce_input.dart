import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class UserIntroduceInput extends StatefulWidget {
  final SignUpViewModel vm;
  const UserIntroduceInput({Key? key, required this.vm}) : super(key: key);

  @override
  _UserIntroduceInputState createState() => _UserIntroduceInputState();
}

class _UserIntroduceInputState extends State<UserIntroduceInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.userIntroduceController.addListener(() {});
  }

  // @override
  // void dispose() {
  //   widget.vm.titleController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('내 소개', style: kLabelTextStyle),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: kTextFieldInnerFontSize, height: 1.5),
              controller: widget.vm.userIntroduceController,
              onTap: () {
                widget.vm.scrollIntroduceFieldToTop();
              },
              maxLines: 5,
              maxLength: 150,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "본인을 자유롭게 표현해주세요",
                hintStyle: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: kTextFieldInnerFontSize),
                contentPadding:
                    EdgeInsets.all(getProportionateScreenHeight(10)),
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
            ))
      ],
    );
  }
}
