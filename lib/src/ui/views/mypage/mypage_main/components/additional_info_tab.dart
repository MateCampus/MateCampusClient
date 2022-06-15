import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/verticalDividerCustom.dart';

class AdditionalInfoTab extends StatelessWidget {
  MypagePresentation myInfo;
  AdditionalInfoTab({Key? key, required this.myInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: getProportionateScreenHeight(5)),
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey.shade100,
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _tabBtn(text: '친구', count: myInfo.friendCount, onTap: () {}),
                VerticalDividerCustom(height: getProportionateScreenHeight(35)),
                _tabBtn(text: '저장', count: myInfo.bookMarkCount, onTap: () {}),
                VerticalDividerCustom(height: getProportionateScreenHeight(35)),
                _tabBtn(text: '내 피드', count: myInfo.feedCount, onTap: () {}),
                VerticalDividerCustom(height: getProportionateScreenHeight(35)),
                _tabBtn(text: '내 댓글', count: myInfo.commentCount, onTap: () {}),
              ]),
        ),
      ),
    );
  }

  Widget _tabBtn(
      {required String text,
      required String count,
      required GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(text,
                style: TextStyle(
                  fontSize: kTextFieldInner,
                  color: Colors.black.withOpacity(0.45),
                )),
            Text(count,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(17),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
