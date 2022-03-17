import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list.dart';

class RecommendUser extends SliverPersistentHeaderDelegate {
  VoiceMainScreenViewModel vm;
  RecommendUser({required this.vm});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      //height: 246,
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [RecommendUserList(vm: vm)],
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 246;

  @override
  // TODO: implement minExtent
  double get minExtent => 246;

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