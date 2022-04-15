import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class ProfileInfo extends StatelessWidget {
  ProfilePresentation profileInfo;
  ProfileInfo({Key? key, required this.profileInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          //vertical: getProportionateScreenHeight(20),
          horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: getProportionateScreenHeight(40),
                  backgroundImage: AssetImage(profileInfo
                      .userImageUrl.first), //추후 누르면 전체화면으로 프사볼수있도록 변경하기
                ),
                Positioned(
                  bottom: 1,
                  right: -1,
                  child: Container(
                      width: getProportionateScreenWidth(20),
                      height: getProportionateScreenHeight(20),
                      decoration: BoxDecoration(
                        color: profileInfo.isOnline
                            ? const Color(0xff00FFBA) //온라인 상태일 때 색
                            : Colors.grey, //오프라인 상태일 떄 색
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white,
                            width: 4.0,
                            style: BorderStyle.solid),
                      )),
                )
              ],
            ),
          ),
          Text(
            profileInfo.userNickname,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          profileInfo.majorName == null
              ? Text(
                  profileInfo.collegeName,
                  style: TextStyle(
                      fontSize: 13, color: Colors.black.withOpacity(0.5)),
                )
              : Text(
                  profileInfo.collegeName + ' / ' + profileInfo.majorName!,
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.5),
                      letterSpacing: 0.5),
                ),
          profileInfo.userIntroduction == null
              ? const VerticalSpacing(of: 20)
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(20)),
                  child: Text(
                    profileInfo.userIntroduction!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                )
        ],
      ),
    );
  }
}
