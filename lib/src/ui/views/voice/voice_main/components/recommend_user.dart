import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list.dart';

class RecommendUser extends SliverPersistentHeaderDelegate {
  VoiceMainScreenViewModel vm;
  RecommendUser({required this.vm});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: getProportionateScreenHeight(246),
      color: mainColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(20), 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '새로운 친구들을 만나보세요!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Text(
              '나와 같은 학교 혹은 관심사가 같은 친구를 추천합니다',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            vm.busy
                ? const IsLoading()
                : (vm.recommendUsers.isEmpty)
                    ? const CenterSentence(
                        sentence:
                            "추천 상대가 존재하지 않습니다.", //추후 대화방 최신순 정렬으로 보여주게끔 바꾸기
                        verticalSpace: 50,
                      )
                    : RecommendUserList(vm: vm)
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => getProportionateScreenHeight(246);

  @override
  // TODO: implement minExtent
  double get minExtent => getProportionateScreenHeight(246);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}



/*원래코드 
class RecommendUser extends StatefulWidget {
  VoiceMainScreenViewModel vm;
  RecommendUser({Key? key, required this.vm}) : super(key: key);

  @override
  State<RecommendUser> createState() => _RecommendUserState();
}

class _RecommendUserState extends State<RecommendUser> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 250,
      child: Column(
        children: [RecommendUserList(vm: widget.vm)],
      ),
    );
  }
}
*/