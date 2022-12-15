import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/show_user_interest.dart';

class UserInfoMore extends StatelessWidget {
  final UserProfileDemandSurveyViewModel vm;
  const UserInfoMore({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (vm.userProfile.introduction.isEmpty)
              ? const SizedBox()
              : _introduction(),
          vm.userInterests.isEmpty
              ? const SizedBox()
              : ShowUserInterest(vm: vm, userInterests: vm.userInterests),
        ],
      ),
    );
  }

  Widget _introduction() {
    return Column(
      children: [
        VerticalSpacing(of: getProportionateScreenHeight(15)),
        Text(
          vm.userProfile.introduction,
          style: TextStyle(
            color: Color(0xff111111),
            height: 1.5,
            fontSize: resizeFont(14),
          ),
        ),
       const  VerticalSpacing()
      ],
    );
  }
}
