import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class TextInputSpace extends StatefulWidget {
  PostCreateScreenViewModel vm;
  TextInputSpace({Key? key, required this.vm}) : super(key: key);

  @override
  _TextInputSpaceState createState() => _TextInputSpaceState();
}

class _TextInputSpaceState extends State<TextInputSpace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '제목',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          const VerticalSpacing(of: 10),
          TextField(
            autofocus: true,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            style: const TextStyle(fontSize: 14),
            controller: widget.vm.titleTextController,
            focusNode: widget.vm.postFocusNode,
            maxLines: 1, //제목 글자수 제한 미정
            decoration: const InputDecoration(
              hintText: "게시물 제목을 입력해주세요",
              hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
              fillColor: screenBackgroundColor,
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
                color: screenBackgroundColor,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  controller: widget.vm.bodyTextController,

                  maxLines: null,
                  minLines: 5, //이걸로 사이즈 조절
                  //style: TextStyle(fontSize: 150),  //테스트용
                  decoration: const InputDecoration(
                    hintText: "게시물 내용을 입력해주세요",
                    hintStyle:
                        TextStyle(color: Color(0xFFADADAD), fontSize: 14),
                    fillColor: screenBackgroundColor,
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
      ),
    );
  }
}
