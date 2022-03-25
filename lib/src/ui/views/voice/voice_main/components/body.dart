import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/voice_room_list.dart';

import 'package:zamongcampus/src/ui/views/voice/voice_main/components/voice_room_list_tile.dart';

class Body extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: RecommendUser(vm: vm),
          pinned: false,
          floating: true,
        ),
        vm.busy
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const IsLoading(),
                  childCount: 1,
                ),
              )
            : (vm.voiceRooms.isEmpty)
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const CenterSentence(
                        sentence: "대화방이 존재하지 않습니다.", //추후 대화방 최신순 정렬으로 보여주게끔 바꾸기
                        verticalSpace: 50,
                      ),
                      childCount: 1,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => VoiceRoomList(vm: vm),
                        childCount:
                            1 //voiceroomlist에서 대화방 개수만큼 카운트 하기 때문에 여기서는 한 번 만 카운트
                        ))
      ],
    );
  }
}
