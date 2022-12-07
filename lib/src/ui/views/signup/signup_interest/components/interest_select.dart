import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_interest/components/selected_interest_chip.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_interest/components/unselected_interest_chip.dart';

class InterestSelect extends StatelessWidget {
  final SignUpViewModel vm;
  const InterestSelect({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Wrap(
            alignment: WrapAlignment.start,
            runSpacing: getProportionateScreenHeight(10), //세로 간격
            spacing: getProportionateScreenWidth(10),
            children: [
              ...vm.systemInterests.map((interest) => interest.isSelected
                  ? ChoiceChip(
                      label:
                          SelectedInterestChip(interestTitle: interest.title),
                      selected: interest.isSelected,
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      onSelected: (bool value) {
                      
                          vm.selectInterest(interest, value);
                        
                        
                      },
                    )
                  : ChoiceChip(
                      label:
                          UnselectedInterestChip(interestTitle: interest.title),
                      selected: interest.isSelected,
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      onSelected: (bool value) {

                        if (vm.selectedInterests.length>=10){
                          toastMessage('관심사는 10개까지만 선택할 수 있습니다');
                        }else {
                          vm.selectInterest(interest, value);
                        }
                      },
                    ))
            ],
          ),
        )
      ],
    );
  }
}
