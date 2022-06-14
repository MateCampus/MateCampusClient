import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
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
        const Text(
          '내 소개',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontSize: 14),
              controller: widget.vm.userIntroduceController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "본인을 자유롭게 표현해주세요",
                hintStyle:
                    const TextStyle(color: Color(0xFFADADAD), fontSize: 14),
                fillColor: screenBackgroundColor,
                filled: true,
                contentPadding:
                    EdgeInsets.all(getProportionateScreenHeight(10)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ))
      ],
    );
  }
}
