import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_disable_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/selected_interest_chip.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/components/unselected_interest_chip.dart';

class SelectInterests extends StatelessWidget {
  final SignUpViewModel vm;
  const SelectInterests({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(20),
              0,
              getProportionateScreenWidth(20),
              getProportionateScreenHeight(100)),
          child: ListView(
            children: [
              Wrap(
                runSpacing: getProportionateScreenHeight(15), //세로 간격
                //alignment: WrapAlignment.spaceBetween,
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
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            ChoiceChip(
                              label:
                                  UnselectedInterestChip(icon: interest.icon),
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
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )
                          ],
                        ))
                ],
              )
            ],
          ),
        ),
        DefaultShadowBox(
          child: Padding(
            padding: defaultPadding,
            child: (vm.isValidNickname && vm.selectedInterests.length >= 3)
                ? DefaultBtn(
                    text: '다음',
                    press: () {
                      Navigator.pushNamed(context, '/signUpOptionalProfile');
                    },
                  )
                : const DefaultDisalbeBtn(text: '다음'), //비활성화 버튼
          ),
        ),
      ],
    );
  }
}
