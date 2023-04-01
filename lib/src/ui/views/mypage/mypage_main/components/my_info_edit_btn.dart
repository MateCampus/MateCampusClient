import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class MyInfoEditBtn extends StatelessWidget {
  final MypageViewModel vm;
  const MyInfoEditBtn({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: getProportionateScreenHeight(10)),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/mypageEditInfo');
          },
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              minimumSize: Size(getProportionateScreenWidth(335),
                  getProportionateScreenHeight(46)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: kMainColor,
              textStyle: TextStyle(
                  fontSize: resizeFont(14), fontWeight: FontWeight.w600)),
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Align(
                alignment: Alignment.center,
                child: Text(
                  '프로필 수정',
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.chevron_right_outlined,
                  ))
            ],
          )),
    );
  }
}
