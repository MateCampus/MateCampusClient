import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/components/fixed_bottom_bar.dart';

class TextInputSpace extends StatefulWidget {
  const TextInputSpace({Key? key}) : super(key: key);

  @override
  _TextInputSpaceState createState() => _TextInputSpaceState();
}

class _TextInputSpaceState extends State<TextInputSpace> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '제목',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
        const VerticalSpacing(of: 10),
        const TextField(
          //autofocus: true,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: 14),
          //controller: widget.textInput,
          maxLines: 1, //제목 글자수 제한 미정
          decoration: InputDecoration(
            hintText: "게시물 제목을 입력해주세요",
            hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
            fillColor: Color(0xfff8f8f8),
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
        const VerticalSpacing(of: 20),
        const Text(
          '내용',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
        const VerticalSpacing(of: 10),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xfff8f8f8),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              (pickedIgms.isEmpty)
                  ? SizedBox()
                  : Text('사진있음'), //여기다가 이미지 있고 없고 판단해서 이미지 보여주면 되겠다.
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 5, //이걸로 사이즈 조절
                //style: TextStyle(fontSize: 150),  //테스트용
                decoration: InputDecoration(
                  hintText: "게시물 내용을 입력해주세요",
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
        ),
      ],
    );
  }
}
