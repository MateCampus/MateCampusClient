import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
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
              style: TextStyle(
                  fontSize: kLabelFontSize,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: Container(
                height: getProportionateScreenHeight(52),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kMainScreenBackgroundColor),
                child: Row(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(52),
                      width: getProportionateScreenWidth(250),
                      child: TextFormField(
                        //validation위해 textformfield 사용
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.send,
                        onFieldSubmitted: (value) {
                          widget.vm.checkIdRedundancy();
                        },
                        style: TextStyle(
                            fontSize: kTextFieldInnerFontSize,
                            color: Colors.black87),
                        controller: widget.vm.userIdController,
                        maxLines: 1,
                        validator: (value) => widget.vm.idValidator(value),
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            CupertinoIcons.person_fill,
                            color: kTextFieldHintColor,
                            size: kTextFieldIconSizeCP,
                          ),
                          hintText: "아이디를 입력해주세요",
                          hintStyle: TextStyle(
                              color: kTextFieldHintColor,
                              fontSize: kTextFieldInnerFontSize),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                      child: TextButton(
                        onPressed: () {
                          widget.vm.checkIdRedundancy(); //아이디 중복확인 및 유효성 검사
                        },
                        child: const Text('중복 확인'),
                        style: TextButton.styleFrom(
                          backgroundColor: kMainColor,
                          primary: Colors.white,
                          textStyle:
                              TextStyle(fontSize: kTextFieldInnerFontSize),
                          minimumSize: Size(getProportionateScreenWidth(55),
                              getProportionateScreenHeight(40)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
