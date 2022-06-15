import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
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
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '아이디',
              style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      //validation위해 textformfield 사용
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: kTextFieldInnerFontSize),
                      controller: widget.vm.userIdController,
                      maxLines: 1,
                      validator: (value) => widget.vm.idValidator(value),

                      decoration: InputDecoration(
                        hintText: "아이디를 입력해주세요",
                        hintStyle: TextStyle(
                            color: Color(0xFFADADAD),
                            fontSize: kTextFieldInnerFontSize),
                        fillColor: kTextFieldColor,
                        filled: true,
                        contentPadding:
                            EdgeInsets.all(getProportionateScreenHeight(10)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: getProportionateScreenWidth(10)),
                    child: TextButton(
                      onPressed: () {
                        widget.vm.checkIdRedundancy(); //아이디 중복확인 및 유효성 검사
                      },
                      child: const Text('중복 확인'),
                      style: TextButton.styleFrom(
                        backgroundColor: kMainColor,
                        primary: Colors.white,
                        minimumSize: Size(getProportionateScreenWidth(70),
                            getProportionateScreenHeight(43)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
