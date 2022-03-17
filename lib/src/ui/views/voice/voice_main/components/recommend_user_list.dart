import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list_tile.dart';

class RecommendUserList extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  RecommendUserList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          //padding: const EdgeInsets.only(right: 100),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: vm.recommendUsers.length,
          itemBuilder: (BuildContext context, int index) {
            return RecommendUserListTile(
                recommendUser: vm.recommendUsers[index]);
          }),
    );
  }
}




/* 원래코드
class RecommendUserList extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  RecommendUserList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(250),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: vm.recommendUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return RecommendUserListTile(
                    recommendUser: vm.recommendUsers[index]);
              }),
        ),
       vm.busy
            ? SizedBox(
                height: getProportionateScreenHeight(250),
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : (vm.voiceRooms.isEmpty
                ? const CenterSentence(
                    sentence: "등록된 게시글이 없습니다.",
                    verticalSpace: 50,
                  )
                : Container()),
      ],
    );
  }
}
*/