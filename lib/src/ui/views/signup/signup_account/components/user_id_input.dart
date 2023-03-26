import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class UserIdInput extends StatefulWidget {
  final SignUpViewModel vm;
  const UserIdInput({Key? key, required this.vm}) : super(key: key);

  @override
  _UserIdInputState createState() => _UserIdInputState();
}

class _UserIdInputState extends State<UserIdInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.userIdController.addListener(() {});
  }

  // @override
  // void dispose() {
  //   widget.vm.titleController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.vm.userIdFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('아이디', style: kLabelTextStyle),
          TextFormField(
            //validation위해 textformfield 사용
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: kTextFieldInnerFontSize,
            ),
            controller: widget.vm.userIdController,
            maxLines: 1,
            validator: (value) => widget.vm.idValidator(value, context),
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "아이디를 입력해주세요",
              hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: kTextFieldInnerFontSize),
            ),
          )
        ],
      ),
    );
  }
}
