import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/user_profile_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/views/user_profile/user_profile_screen.dart';

class PostHead extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  const PostHead({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            vm.workHistoryFeedToProfile();
            vm.postDetail.loginId == AuthService.loginId
                ? Navigator.pushNamed(context, UserProfileScreen.routeName,
                    arguments: UserProfileScreenArgs(
                        loginId: vm.postDetail.loginId, hasBottomBtn: false))
                : Navigator.pushNamed(context, UserProfileScreen.routeName,
                    arguments: UserProfileScreenArgs(
                        loginId: vm.postDetail.loginId, hasBottomBtn: true));
          },
          child: _postUser(),
        ),
        vm.postDetail.categories.isEmpty ? const SizedBox() : _postCategories()
      ],
    );
  }

  Widget _postUser() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: getProportionateScreenHeight(18),
        backgroundImage: vm.postDetail.userImageUrl.startsWith('https')
            ? CachedNetworkImageProvider(vm.postDetail.userImageUrl)
                as ImageProvider
            : AssetImage(vm.postDetail.userImageUrl),
      ),
      title: Text(
        vm.postDetail.userNickname,
        style: TextStyle(
            fontSize: resizeFont(12),
            color: Color(0xff111111),
            fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        vm.postDetail.collegeName + ' \u{00B7} ' + vm.postDetail.createdAt,
        style: TextStyle(
            fontSize: resizeFont(12),
            color: Color(0xff767676),
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _postCategories() {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: getProportionateScreenWidth(8),
        children: [
          ...vm.postDetail.categories.map((category) => Chip(
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: const VisualDensity(vertical: -4),
                label: Text(category),
                labelStyle: TextStyle(
                  fontSize: resizeFont(12),
                  color: kMainColor,
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: Colors.white,
                side: BorderSide(color: Color(0xffF8E9E7), width: 1.2),
              ))
        ],
      ),
    );
  }
}
