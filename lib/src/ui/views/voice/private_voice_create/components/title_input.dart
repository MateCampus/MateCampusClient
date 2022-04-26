import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
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

    widget.vm.titleController.addListener(() {
      //widget.vm.setTitle();
    });
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
      children: const [
        Text(
          '대화방 정보',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
        VerticalSpacing(of: 10),
        TextField(
          //autofocus: true,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: 14),
          //controller: widget.textInput,
          maxLines: 1, //제목 글자수 제한 미정
          decoration: InputDecoration(
            hintText: "어떤 얘기를 나눠볼까요?",
            hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
            fillColor: Color(0xfff8f8f8),
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
