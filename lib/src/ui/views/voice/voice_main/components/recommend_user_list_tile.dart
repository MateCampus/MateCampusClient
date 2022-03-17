import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';

class RecommendUserListTile extends StatelessWidget {
  UserPresentation recommendUser;
  RecommendUserListTile({Key? key, required this.recommendUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 133,
      width: 116,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(recommendUser.imageUrls.first)),
          const SizedBox(height: 10),
          Text(recommendUser.majorName),
          const SizedBox(height: 5),
          Text(recommendUser.collegeName),
          Card()
        ],
      ),
    );
  }
}
