import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class TitleInput extends StatefulWidget {
  final VoiceCreateViewModel vm;
  const TitleInput({Key? key, required this.vm}) : super(key: key);

  @override
  State<TitleInput> createState() => _TitleInputState();
}

class _TitleInputState extends State<TitleInput> {
  @override
  void initState() {
    super.initState();

    widget.vm.titleController.addListener(() {});
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
        Text(
          '대화방 정보',
          style: TextStyle(fontSize: kLabel, color: Colors.black87),
        ),
        const VerticalSpacing(of: 10),
        TextFormField(
          //autofocus: true,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: kTextFieldInner),
          controller: widget.vm.titleController,
          maxLines: 1,
          autovalidateMode:
              AutovalidateMode.onUserInteraction, //값이 들어오는 순간부터 자동 유효성 검사
          validator: (value) => widget.vm.titleValidator(value),
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "어떤 얘기를 나눠볼까요?",
            hintStyle:
                TextStyle(color: Color(0xFFADADAD), fontSize: kTextFieldInner),
            fillColor: screenBackgroundColor,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
      ],
    );
  }
}
