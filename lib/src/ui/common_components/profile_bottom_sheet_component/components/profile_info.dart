import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class ProfileInfo extends StatelessWidget {
  String imageUrl;
  String nickname;
  String? majorName;
  String collegeName;
  String? introduction;

  ProfileInfo(
      {Key? key,
      required this.imageUrl,
      required this.nickname,
      required this.majorName,
      required this.collegeName,
      required this.introduction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          _profileImg(context),
          _nicknameWithCollege(),
          introduction == null ? const VerticalSpacing(of: 10) : _introduction()
        ],
      ),
    );
  }

  Widget _profileImg(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showOriginalProfileImage(context, imageUrl);
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: getProportionateScreenHeight(40),
            backgroundColor: Colors.grey,
            backgroundImage: imageUrl.startsWith('https')
                ? CachedNetworkImageProvider(imageUrl) as ImageProvider
                : AssetImage(
                    imageUrl,
                  ),
          ),
          // Positioned(
          //   bottom: 1,
          //   right: -1,
          //   child: Container(
          //       width: getProportionateScreenWidth(20),
          //       height: getProportionateScreenHeight(20),
          //       decoration: BoxDecoration(
          //         color: userProfile.isOnline
          //             ? const Color(0xff00FFBA) //온라인 상태일 때 색
          //             : Colors.grey, //오프라인 상태일 떄 색
          //         shape: BoxShape.circle,
          //         border: Border.all(
          //             color: Colors.white,
          //             width: 4.0,
          //             style: BorderStyle.solid),
          //       )),
          // )
        ],
      ),
    );
  }

  Widget _nicknameWithCollege() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Column(
        children: [
          Text(
            nickname,
            style: TextStyle(
                fontSize: kTitleFontSize, fontWeight: FontWeight.w700),
          ),
          const VerticalSpacing(of: 3),
          majorName == null
              ? Text(
                  collegeName,
                  style: TextStyle(
                      fontSize: resizeFont(13),
                      color: Colors.black.withOpacity(0.7)),
                )
              : Text(
                  collegeName + ' / ' + majorName!,
                  style: TextStyle(
                      fontSize: resizeFont(13),
                      color: Colors.black.withOpacity(0.7),
                      letterSpacing: 0.5),
                ),
        ],
      ),
    );
  }

  Widget _introduction() {
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(10),
          bottom: getProportionateScreenHeight(20)),
      child: Text(
        introduction!,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: kPlainTextFontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5),
      ),
    );
  }
}
