import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class FriendListTile extends StatefulWidget {
  FriendPresentation user;
  FriendListTile({Key? key, required this.user}) : super(key: key);

  @override
  State<FriendListTile> createState() => _FriendListTileState();
}

bool _isChecked = false;

class _FriendListTileState extends State<FriendListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(15)),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(widget.user.userImageUrl),
            ),
            Positioned(
              bottom: 1,
              right: -1,
              child: Container(
                  width: getProportionateScreenWidth(15),
                  height: getProportionateScreenHeight(15),
                  decoration: BoxDecoration(
                    color: widget.user.isOnline
                        ? const Color(0xff00FFBA) //온라인 상태일 때 색
                        : Colors.grey, //오프라인 상태일 떄 색
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white,
                        width: 3.0,
                        style: BorderStyle.solid),
                  )),
            )
          ],
        ),
        title: Text(
          widget.user.userNickname,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.check_circle,
          color: _isChecked ? mainColor : Colors.grey,
        ),
        contentPadding: const EdgeInsets.all(0),
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
          });
        },
      ),
    );
  }
}
