import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/circle_image_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class UserInfo extends SliverPersistentHeaderDelegate {
  UserProfileDemandSurveyViewModel vm;
  UserInfo({required this.vm});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacing(),
          _nicknameCollegeImage(context),
          const VerticalSpacing(),
          vm.userProfile.introduction ==null
            ? const VerticalSpacing(of:10)
            : _introduction()
          //관심사 
          
          
        ],
      ),
    );
  }

  Widget _nicknameCollegeImage(context){
    return Row(
            children: [
              CircleImageBtn(
                      imageUrl: vm.userProfile.imageUrl,
                      press: () {
                        showOriginalProfileImage(
                            context,
                            vm.userProfile.imageUrl
                            );
                      },
                      size: getProportionateScreenHeight(80)),
              Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vm.userProfile.nickname,
                      style: TextStyle(
                          color: Color(0xff111111),
                          fontSize: resizeFont(18),
                          fontWeight: FontWeight.w700),
                    ),
                    const VerticalSpacing(of: 5),
                    Text(
                      vm.userProfile.collegeName,
                      style: TextStyle(
                          fontSize: resizeFont(13),
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _introduction(){
    return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(5),
            ),
            child: Text(
              vm.userProfile.introduction!,
              style: TextStyle(
                color: Color(0xff111111),
                fontSize: resizeFont(14),
              ),
            ),
          );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => getProportionateScreenHeight(350);

  @override
  // TODO: implement minExtent
  double get minExtent => getProportionateScreenHeight(350);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
