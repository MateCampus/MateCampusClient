import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/voice_detail_screen.dart';

class VoiceRoomListTile extends StatelessWidget {
  final VoiceRoomPresentation voiceRoom;
  const VoiceRoomListTile({Key? key, required this.voiceRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, VoiceDetailScreen.routeName,
            arguments: VoiceDetailScreenArgs(id: voiceRoom.id));
      }),
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey.shade100,
        elevation: 4.0,
        margin: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(20),
            getProportionateScreenHeight(10),
            getProportionateScreenWidth(20),
            0),
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                //카테고리 나열
                children: [
                  ...voiceRoom.categories.map((category) => Text(
                        category + "\t\t\t",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: kInterestTextFontSize,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              const VerticalSpacing(of: 10),
              Text(
                voiceRoom.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                    fontSize: resizeFont(15)),
              ),
              const VerticalSpacing(of: 10),
              Row(
                //TODO:대화방 참여자 나열 -> 참여자가 많아졌을 때 overflow되는거 고쳐야함. listview? 아니면 Text overflow처럼 처리할 수 없나?
                children: [
                  ...voiceRoom.memberImgUrls.map((imageUrl) => Container(
                        width: getProportionateScreenWidth(25),
                        height: getProportionateScreenHeight(25),
                        margin: EdgeInsets.only(
                            right: getProportionateScreenWidth(3)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageUrl.startsWith('https')
                                    ? CachedNetworkImageProvider(imageUrl)
                                        as ImageProvider
                                    : AssetImage(imageUrl))),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
