import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class PostDeletedMsg extends StatelessWidget {
  const PostDeletedMsg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '게시물을 삭제하시겠습니까?',
      style: TextStyle(fontSize: getProportionateScreenWidth(14)),
    );
  }
}
