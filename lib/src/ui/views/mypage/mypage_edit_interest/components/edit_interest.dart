import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/selected_interest_chip.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/unselected_interest_chip.dart';

class EditInterest extends StatefulWidget {
  final MypageViewModel vm;
  const EditInterest({Key? key, required this.vm}) : super(key: key);

  @override
  _EditInterestState createState() => _EditInterestState();
}

class _EditInterestState extends State<EditInterest> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: ListView(
        children: [
          Center(
            child: Wrap(
              alignment: WrapAlignment.start,
              runSpacing: getProportionateScreenHeight(6), //세로 간격
              spacing: getProportionateScreenWidth(14),
              children: [
                ...widget.vm.allInterestsAfterLoad.map(
                  (interest) => interest.isSelected
                      ? ChoiceChip(
                          label: SelectedInterestChip(
                              interestTitle: interest.title),
                          selected: interest.isSelected,
                          selectedColor: Colors.white,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          onSelected: (bool value) {
                            widget.vm.changeInterestStatus(interest, value);
                          },
                        )
                      : ChoiceChip(
                          label: UnselectedInterestChip(
                              interestTitle: interest.title),
                          selected: interest.isSelected,
                          selectedColor: Colors.white,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          onSelected: (bool value) {
                            if (widget.vm.selectedInterestCodes.length >= 10) {
                              toastMessage('관심사는 최대 10개까지 선택할 수 있습니다');
                            } else {
                              widget.vm.changeInterestStatus(interest, value);
                            }
                          },
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
