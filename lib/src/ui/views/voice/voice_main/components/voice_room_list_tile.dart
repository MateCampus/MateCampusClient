import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class VoiceRoomListTile extends StatelessWidget {
  VoiceRoomPresentation voiceRoom;
  VoiceRoomListTile({Key? key, required this.voiceRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      margin: EdgeInsets.fromLTRB(getProportionateScreenWidth(20),
          getProportionateScreenHeight(10), getProportionateScreenWidth(20), 0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //카테고리 나열
              children: [
                ...voiceRoom.categories.map((category) => Text(
                      category + "  ",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ))
              ],
            ),
            const VerticalSpacing(of: 10),
            Text(
              voiceRoom.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const VerticalSpacing(of: 10),
            Row(
              //대화방 참여자 나열
              children: [
                ...voiceRoom.memberImageUrls.map((imageUrl) => Container(
                      width: 25.0,
                      height: 25.0,
                      margin: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: AssetImage(imageUrl))),
                    )),
                const Spacer(),
                Text(voiceRoom.createdAt),
              ],
            ),
          ],
        ),
      ),
    );

    /*원래코드
    Container(
      child: Column(
        children: [
          Text(voiceRoom.title),
          ...voiceRoom.categories.map((category) => Text(category)),
          Text(voiceRoom.createdAt),
          ...voiceRoom.memberImageUrls.map(
            (imageUrl) => Image.asset(imageUrl),
          ),
          const Text("----- 여기까지"),
        ],
      ),
    );
    */
  }
}
