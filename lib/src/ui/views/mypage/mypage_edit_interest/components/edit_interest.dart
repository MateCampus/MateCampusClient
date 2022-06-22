import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
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
              alignment: WrapAlignment.spaceAround,
              runSpacing: getProportionateScreenHeight(15), //세로 간격
              spacing: getProportionateScreenWidth(25),
              children: [
                ...widget.vm.allInterestsAfterLoad.map((interest) => interest
                        .isSelected
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
                              widget.vm.changeInterestStatus(interest, value);
                            },
                          ),
                          Text(
                            interest.title,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(10.5),
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
                              widget.vm.changeInterestStatus(interest, value);
                            },
                          ),
                          Text(
                            interest.title,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(10.5),
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
