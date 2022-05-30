import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/selected_interest_chip.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/components/unselected_interest_chip.dart';

class EditInterest extends StatefulWidget {
  MypageViewModel vm;
  EditInterest({Key? key, required this.vm}) : super(key: key);

  @override
  _EditInterestState createState() => _EditInterestState();
}

class _EditInterestState extends State<EditInterest> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Padding(
        padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(30), 0,
            getProportionateScreenWidth(30), getProportionateScreenHeight(70)),
        child: ListView(
          children: [
            Wrap(
              runSpacing: getProportionateScreenHeight(15), //세로 간격
              //alignment: WrapAlignment.spaceBetween,
              spacing: getProportionateScreenWidth(25),
              children: [
                ...widget.vm.myInterests.map((interest) => interest.isSelected
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
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
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
          child: DefaultBtn(
            text: widget.vm.selectedInterests.length.toString() + '개 선택됨',
            press: () {
              widget.vm.updateInterests(context: context);
            },
          ),
        ),
      )
    ]);
  }
}
