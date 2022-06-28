import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
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
          color: kMainColor,
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
                        )
                      : Expanded(child: RecommendUserList(vm: vm)),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(5),
              bottom: getProportionateScreenHeight(5)),
          child: Row(
            children: [
              Text(
                // '실시간 대화방\u{1F399}',
                '실시간 대화방 ',
                style: TextStyle(
                    fontFamily: 'Gmarket',
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w500),
              ),
              Icon(
                FontAwesomeIcons.microphone,
                size: getProportionateScreenHeight(18),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      '새로고침 ',
                      style: TextStyle(
                          fontSize: resizeFont(12),
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(CupertinoIcons.arrow_clockwise,
                        size: getProportionateScreenWidth(12)),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 1.5,
                    primary: Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              // ElevatedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(CupertinoIcons.arrow_clockwise,
              //       size: getProportionateScreenWidth(12)),
              //   label: Text(
              //     '새로고침',
              //     style: TextStyle(
              //         fontSize: resizeFont(12), fontWeight: FontWeight.w300),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //       elevation: 1.5,
              //       primary: Color(0xffAFABAB),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //       )),
              // ),
              // TextButton.icon(
              //   onPressed: () {
              //     vm.refreshPage();
              //   },
              //   icon: const Icon(CupertinoIcons.arrow_clockwise, size: 0),
              //   label: Wrap(
              //       crossAxisAlignment: WrapCrossAlignment.center,
              //       children: const [
              //         Text(
              //           "새로고침 ",
              //           style: TextStyle(fontSize: 13),
              //         ),
              //         Icon(CupertinoIcons.arrow_clockwise, size: 13)
              //       ]),
              // ),
            ],
          ),
        )
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
                fontSize: kTitleFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          const VerticalSpacing(of: 5),
          Text(
            '하루에 한 번, 나와 어울리는 친구들을 추천해줘요!',
            style: TextStyle(
                fontFamily: 'Gmarket',
                fontWeight: FontWeight.w300,
                fontSize: kPlainTextFontSize,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => getProportionateScreenHeight(300);

  @override
  // TODO: implement minExtent
  double get minExtent => getProportionateScreenHeight(300);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
