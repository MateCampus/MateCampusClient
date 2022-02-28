import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list_tile.dart';

class RecommendUserList extends StatelessWidget {
  VoiceMainScreenViewModel model;
  RecommendUserList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(250),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: model.recommendUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return RecommendUserListTile(
                    recommendUser: model.recommendUsers[index]);
              }),
        ),
        model.busy
            ? SizedBox(
                height: getProportionateScreenHeight(400),
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : (model.voiceRooms.isEmpty
                ? const CenterSentence(
                    sentence: "등록된 게시글이 없습니다.",
                    verticalSpace: 50,
                  )
                : Container()),
      ],
    );
  }
}
