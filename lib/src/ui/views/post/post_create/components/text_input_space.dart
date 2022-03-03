import 'package:flutter/material.dart';

class TextInputSpace extends StatefulWidget {
  const TextInputSpace({Key? key}) : super(key: key);

  @override
  _TextInputSpaceState createState() => _TextInputSpaceState();
}

class _TextInputSpaceState extends State<TextInputSpace> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      keyboardType: TextInputType.multiline,
      //controller: widget.textInput,
      maxLines: null,
      //minLines: 5,  //이걸로 사이즈 조절 가능할듯 아니 근데 그러면 최소 5줄을 써야 된다는거잖아..말이되냐
      //style: TextStyle(fontSize: 150),
      decoration: InputDecoration(
        hintText: "내용을 입력해주세요",
        hintStyle: TextStyle(color: Color(0xFFADADAD)),
        fillColor: Color(0xfff8f8f8),
        filled: true,
        border: InputBorder.none,
      ),
    );
  }
}
