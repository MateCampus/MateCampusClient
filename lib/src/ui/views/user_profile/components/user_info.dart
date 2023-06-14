import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/circle_image_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/show_user_interest.dart';

class UserInfo extends SliverPersistentHeaderDelegate {
  UserProfileDemandSurveyViewModel vm;
  UserInfo({required this.vm});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(color: kMainScreenBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _nicknameCollegeImage(context),
        ],
      ),
    );
  }

  Widget _nicknameCollegeImage(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        children: [
          CircleImageBtn(
              imageUrl: vm.userProfile.imageUrl,
              press: () {
                vm.workHistoryProfilePhoto();
                showOriginalProfileImage(context, vm.userProfile.imageUrl);
              },
              size: getProportionateScreenHeight(90)),
          Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vm.userProfile.nickname,
                  style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: resizeFont(20),
                      fontWeight: FontWeight.w700),
                ),
                const VerticalSpacing(of: 5),
                Text(
                  vm.userProfile.collegeName,
                  style: TextStyle(
                      fontSize: resizeFont(14), color: Color(0xff767676)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => getProportionateScreenHeight(100);

  @override
  // TODO: implement minExtent
  double get minExtent => getProportionateScreenHeight(100);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
