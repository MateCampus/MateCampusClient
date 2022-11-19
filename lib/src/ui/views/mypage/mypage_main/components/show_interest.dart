import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/my_interest_edit_btn.dart';

class ShowInterest extends StatelessWidget {
  final MypageViewModel vm;
  const ShowInterest({Key? key, required this.vm}) : super(key: key);

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
            runSpacing: getProportionateScreenHeight(10),
            spacing: getProportionateScreenWidth(8),
            children: [
              ...vm.selectedInterestCodes.map((interest) => Chip(
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(vertical: -2),
                    label: Text(InterestData.korNameOf(interest.name)),
                    labelStyle: TextStyle(
                      fontSize: resizeFont(14),
                      color: const Color(0xff111111),
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: const Color(0xffE5E5EC),
                    side:
                        const BorderSide(color: Color(0xffE5E5EC), width: 1.2),
                  )),
              MyInterestEditBtn(vm: vm)
            ],
          ),
        ],
      ),
    );
  }
}
