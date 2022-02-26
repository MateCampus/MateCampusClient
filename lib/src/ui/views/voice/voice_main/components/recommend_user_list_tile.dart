import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';

class RecommendUserListTile extends StatelessWidget {
  UserPresentation recommendUser;
  RecommendUserListTile({Key? key, required this.recommendUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(recommendUser.imageUrl.first,
            height: 200, width: 200, fit: BoxFit.fill),
        Text(recommendUser.majorName),
        Text(recommendUser.collegeName)
      ],
    );
  }
}
