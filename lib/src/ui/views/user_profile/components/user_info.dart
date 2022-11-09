import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class UserInfo extends SliverPersistentHeaderDelegate {
  UserProfileDemandSurveyViewModel vm;
  UserInfo({required this.vm});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Text(vm.userProfile.loginId);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => getProportionateScreenHeight(300);

  @override
  // TODO: implement minExtent
  double get minExtent => getProportionateScreenHeight(300);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
