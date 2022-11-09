import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/circle_image_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class ShowInfo extends StatelessWidget {
  final MypageViewModel vm;
  const ShowInfo({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(5),
          horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              vm.changedProfileImgPath.isEmpty
                  ? CircleImageBtn(
                      imageUrl: vm.myInfo.imageUrl,
                      press: () {
                        showOriginalProfileImage(
                            context,
                            vm.changedProfileImgPath.isEmpty
                                ? vm.myInfo.imageUrl
                                : vm.changedProfileImgPath);
                      },
                      size: getProportionateScreenHeight(80))
                  : CircleImageBtn(
                      imageUrl: vm.changedProfileImgPath,
                      press: () {
                        showOriginalProfileImage(
                            context,
                            vm.changedProfileImgPath.isEmpty
                                ? vm.myInfo.imageUrl
                                : vm.changedProfileImgPath);
                      },
                      size: getProportionateScreenHeight(80)),
              Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vm.myInfo.nickname,
                      style: TextStyle(
                          color: Color(0xff111111),
                          fontSize: resizeFont(18),
                          fontWeight: FontWeight.w700),
                    ),
                    const VerticalSpacing(of: 5),
                    Text(
                      vm.myInfo.collegeName,
                      style: TextStyle(
                          fontSize: resizeFont(13),
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const VerticalSpacing(),
          //소개글 영역
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(5),
            ),
            child: Text(
              vm.myInfo.introduction,
              style: TextStyle(
                color: Color(0xff111111),
                fontSize: resizeFont(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileEditBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/mypageEditInfo');
      },
      child: Container(
        width: getProportionateScreenWidth(30),
        height: getProportionateScreenHeight(30),
        decoration: BoxDecoration(
          color: kMainColor,
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white, width: 3.0, style: BorderStyle.solid),
        ),
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: getProportionateScreenHeight(15),
        ),
      ),
    );
  }

  Widget _interestEditBtn(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/mypageEditInterest');
        },
        style: TextButton.styleFrom(
            primary: Colors.white,
            minimumSize: Size(getProportionateScreenWidth(335),
                getProportionateScreenHeight(50)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: kMainColor,
            textStyle: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                fontWeight: FontWeight.bold)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                '내 관심사 ' + vm.myInfo.interestCount,
              ),
            ),
            const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.chevron_right_outlined,
                ))
          ],
        ));
  }
}
