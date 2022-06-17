import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/now_text.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/voice_room_list.dart';

import 'package:zamongcampus/src/ui/views/voice/voice_main/components/voice_room_list_tile.dart';

class Body extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
              SliverPersistentHeader(
                // recommendUser 안에 "Now(오렌지)" 까지 포함됨.
                delegate: RecommendUser(vm: vm),
                pinned: false,
                floating: true,
              ),
            ],
        body: vm.busy
            ? const IsLoading()
            : (vm.voiceRooms.isEmpty)
                ? const CenterSentence(
                    sentence: "대화방이 존재하지 않습니다.", //추후 대화방 최신순 정렬으로 보여주게끔 바꾸기
                    verticalSpace: 50,
                  )
                : RefreshIndicator(
                    displacement: 0,
                    onRefresh: vm.refreshPage,
                    child: VoiceRoomList(vm: vm)));
  }
}
