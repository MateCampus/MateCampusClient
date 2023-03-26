import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/arguments/user_profile_screen_args.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_liked_list_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';
import 'package:zamongcampus/src/ui/views/user_profile/user_profile_screen.dart';

class LikedUserListTile extends StatelessWidget {
  final PostLikedListViewModel vm;
  final PostLikedUserPresentation likeduser;
  const LikedUserListTile({Key? key, required this.vm, required this.likeduser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            likeduser.loginId == AuthService.loginId
                ? Navigator.pushNamed(context, UserProfileScreen.routeName,
                    arguments: UserProfileScreenArgs(
                        loginId: likeduser.loginId, hasBottomBtn: false))
                : Navigator.pushNamed(context, UserProfileScreen.routeName,
                    arguments: UserProfileScreenArgs(
                        loginId: likeduser.loginId, hasBottomBtn: true));
          },
          child: ListTile(
            dense: true,
            visualDensity: const VisualDensity(horizontal: -2),
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: getProportionateScreenHeight(18),
              backgroundImage: likeduser.profileImageUrl.startsWith('https')
                  ? CachedNetworkImageProvider(likeduser.profileImageUrl)
                      as ImageProvider
                  : AssetImage(likeduser.profileImageUrl),
            ),
            title: Text(
              likeduser.nickname,
              style: TextStyle(
                  fontSize: resizeFont(12),
                  color: Color(0xff111111),
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              likeduser.collegeName,
              style: TextStyle(
                  fontSize: resizeFont(12),
                  color: Color(0xff767676),
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        const HorizontalDividerCustom(
          color: Color(0xfff0f0f6),
        )
      ],
    );
  }
}
