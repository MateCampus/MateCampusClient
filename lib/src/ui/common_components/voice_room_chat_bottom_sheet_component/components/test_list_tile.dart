import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

//삭제 예정 -> voice_chat 띄우고 난 후에 채팅부분 다시 수정 예정.
class TestListTile extends StatelessWidget {
  final int index;
  const TestListTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 0,
      horizontalTitleGap: getProportionateScreenWidth(10),
      dense: true,
      leading: CircleAvatar(
        radius: getProportionateScreenWidth(17),
        backgroundImage: AssetImage('assets/images/user/general_user.png'),
      ),
      title: Text(
        '닉네임',
        style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Text(
            '$index',
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          )
        ],
      ),
    );
  }
}
