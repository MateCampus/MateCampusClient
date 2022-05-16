import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class EditText extends StatefulWidget {
  TextEditingController nicknameController;
  TextEditingController introductionController;
  EditText(
      {Key? key,
      required this.nicknameController,
      required this.introductionController})
      : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '내 소개',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: TextFormField(
              //validation위해 textformfield 사용
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontSize: 14),
              controller: widget.nicknameController,
              maxLines: 1,

              decoration: const InputDecoration(
                hintText: "닉네임",
                hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
                fillColor: Color(0xfff8f8f8),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            style: const TextStyle(fontSize: 14),
            controller: widget.introductionController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "본인을 자유롭게 표현해주세요",
              hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
              fillColor: Color(0xfff8f8f8),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
        ],
      ),
    );
  }
}
