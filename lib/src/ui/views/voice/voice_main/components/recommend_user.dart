import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list.dart';

class RecommendUser extends SliverPersistentHeaderDelegate {
  VoiceMainScreenViewModel vm;
  RecommendUser({required this.vm});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        Container(
          height: getProportionateScreenHeight(246),
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(25)),
          color: mainColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerText(),
              vm.busy
                  ? const Expanded(child: IsLoading())
                  : (vm.recommendUsers.isEmpty)
                      ? const CenterSentence(
                          sentence:
                              "추천 상대가 존재하지 않습니다.", //추후 대화방 최신순 정렬으로 보여주게끔 바꾸기
                          verticalSpace: 50,
                        )
                      : Expanded(child: RecommendUserList(vm: vm)),
            ],
          ),
        ),
        Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(20),
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(10)),
            child: Text(
              'NOW\u{1F34A}',
              style: TextStyle(
                  fontFamily: 'Gmarket',
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.w700),
            ))
      ],
    );
  }

  Widget _headerText() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '새로운 친구들을 만나보세요! \u{1F440}',
            style: TextStyle(
                fontFamily: 'Gmarket',
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          const VerticalSpacing(of: 5),
          Text(
            '나와 같은 학교 혹은 관심사가 같은 친구를 추천합니다',
            style: TextStyle(
                fontFamily: 'Gmarket',
                fontWeight: FontWeight.w300,
                fontSize: getProportionateScreenHeight(13),
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => getProportionateScreenHeight(310);

  @override
  // TODO: implement minExtent
  double get minExtent => getProportionateScreenHeight(310);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
