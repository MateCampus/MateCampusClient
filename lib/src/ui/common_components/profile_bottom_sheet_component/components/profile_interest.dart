import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/interest_different_chip.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/interest_none_chip.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/interest_same_chip.dart';

class ProfileInterest extends StatelessWidget {
  List<InterestPresentation> profileInterests;
  ProfileInterest({Key? key, required this.profileInterests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(100),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(5)),
        child: Wrap(
          runSpacing: getProportionateScreenHeight(3),
          alignment: WrapAlignment.center,
          spacing: getProportionateScreenWidth(5),
          children: [
            ...profileInterests.map((interest) {
              switch (interest.status) {
                case InterestStatus.same:
                  return InterestSameChip(interest: interest);

                case InterestStatus.different:
                  return InterestDifferentChip(interest: interest);
                default: //status.none 상태
                  return InterestNoneChip(interest: interest);
              }
            })
          ],
        ),
      ),
    );
  }
}
