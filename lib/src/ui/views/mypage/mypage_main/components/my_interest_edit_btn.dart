import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class MyInterestEditBtn extends StatelessWidget {
  final MypageViewModel vm;
  const MyInterestEditBtn({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/mypageEditInterest');
      },
      child: Chip(
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(vertical: -4),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.add,
              size: getProportionateScreenWidth(12),
              color: kMainColor,
            ),
            const Text(
              ' 추가',
            ),
          ],
        ),
        labelStyle: TextStyle(
          fontSize: resizeFont(12),
          color: kMainColor,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.white,
        side: BorderSide(color: kMainColor, width: 1.2),
      ),
    );
  }
}
