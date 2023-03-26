import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class BlockUserMsg extends StatelessWidget {
  const BlockUserMsg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '상대방을 차단하시겠습니까?\n차단한 상대와는 대화를 할 수 없습니다.',
      style: TextStyle(fontSize: resizeFont(14)),
    );
  }
}
