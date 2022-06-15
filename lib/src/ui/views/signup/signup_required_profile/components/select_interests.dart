import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/selected_interest_chip.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/unselected_interest_chip.dart';

class SelectInterests extends StatelessWidget {
  final SignUpViewModel vm;
  const SelectInterests({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: ListView(
        children: [
          Center(
            child: Wrap(
              runSpacing: getProportionateScreenHeight(15), //세로 간격
              spacing: getProportionateScreenWidth(25),
              children: [
                ...vm.systemInterests.map((interest) => interest.isSelected
                    ? Column(
                        children: [
                          ChoiceChip(
                            label: SelectedInterestChip(icon: interest.icon),
                            selected: interest.isSelected,
                            selectedColor: Colors.white,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            onSelected: (bool value) {
                              vm.selectInterest(interest, value);
                            },
                          ),
                          Text(
                            interest.title,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          ChoiceChip(
                            label: UnselectedInterestChip(icon: interest.icon),
                            selected: interest.isSelected,
                            selectedColor: Colors.white,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            onSelected: (bool value) {
                              vm.selectInterest(interest, value);
                            },
                          ),
                          Text(
                            interest.title,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
