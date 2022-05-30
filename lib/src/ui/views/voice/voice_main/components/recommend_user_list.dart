import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list_tile.dart';

class RecommendUserList extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  RecommendUserList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          getProportionateScreenWidth(20),
          getProportionateScreenHeight(10),
          0,
          getProportionateScreenHeight(10)),
      child: ListView.builder(
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
