import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/models/enums/interestStatus.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class ShowUserInterest extends StatelessWidget {
  final UserProfileDemandSurveyViewModel vm;
  List<InterestPresentation> userInterests;
  ShowUserInterest({Key? key, required this.vm, required this.userInterests})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '관심사',
            style: TextStyle(
                color: Color(0xff776677),
                fontSize: resizeFont(14),
                fontWeight: FontWeight.w500),
          ),
          const VerticalSpacing(of: 10),
          Wrap(
            alignment: WrapAlignment.start,
            runSpacing: getProportionateScreenHeight(8),
            spacing: getProportionateScreenWidth(6),
            children: [
              ...userInterests.map((interest) {
                switch (interest.status) {
                  case InterestStatus.SAME:
                    return _sameChip(interest);

                  case InterestStatus.DIFFERENT:
                    return _differentChip(interest);
                  default: //status.none 상태인데 바뀐 정책에서는 안보여주니까 그냥 이렇게두자.
                    return const SizedBox();
                }
              })
            ],
          ),
        ],
      ),
    );
  }

  Widget _differentChip(InterestPresentation interest) {
    return Chip(
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(vertical: -2),
      label: Text(interest.title),
      labelStyle: TextStyle(
        fontSize: resizeFont(12),
        color: const Color(0xff111111),
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: const Color(0xffE5E5EC),
      side: const BorderSide(color: Color(0xffE5E5EC), width: 1.2),
    );
  }

  Widget _sameChip(InterestPresentation interest) {
    return Chip(
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(vertical: -2),
      label: Text(interest.title),
      labelStyle: TextStyle(
        fontSize: resizeFont(12),
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: kMainColor,
      side: const BorderSide(color: kMainColor, width: 1.2),
    );
  }
}
