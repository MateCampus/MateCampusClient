import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class NicknameInput extends StatefulWidget {
  final SignUpViewModel vm;
  const NicknameInput({Key? key, required this.vm}) : super(key: key);

  @override
  _NicknameInputState createState() => _NicknameInputState();
}

class _NicknameInputState extends State<NicknameInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.userNicknameController.addListener(() {});
  }

  // @override
  // void dispose() {
  //   widget.vm.titleController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        //vertical: getProportionateScreenHeight(10)
      ),
      child: Form(
        key: widget.vm.userNicknameFormKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '닉네임',
                style: TextStyle(fontSize: 12, color: Colors.black87),
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
                        style: const TextStyle(fontSize: 14),
                        controller: widget.vm.userNicknameController,
                        maxLines: 1,
                        validator: (value) =>
                            widget.vm.nicknameValidator(value),

                        decoration: InputDecoration(
                          hintText: "닉네임을 입력해주세요",
                          hintStyle: const TextStyle(
                              color: Color(0xFFADADAD), fontSize: 14),
                          fillColor: const Color(0xfff8f8f8),
                          filled: true,
                          contentPadding:
                              EdgeInsets.all(getProportionateScreenHeight(10)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(10)),
                      child: TextButton(
                        onPressed: () {
                          widget.vm
                              .checkNicknameRedundancy(); //닉네임 중복확인 및 유효성 검사
                        },
                        child: const Text('중복 확인'),
                        style: TextButton.styleFrom(
                          backgroundColor: mainColor,
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
      ),
    );
  }
}
