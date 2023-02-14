import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Text(
              '안내',
              style: TextStyle(
                  color: Color(0xff767676),
                  fontSize: resizeFont(14),
                  fontWeight: FontWeight.w500),
            ),
          ),
          // VerticalSpacing(of: 10),
          // _tabBtn(text: '공지사항', onTap: () {}),
          // const HorizontalDividerCustom(
          //   color: Color(0xfff0f0f6),
          // ),
          _tabBtn(
              text: '문의하기',
              onTap: () {
                Navigator.pushNamed(context, "/inquiry");
              }),
          const HorizontalDividerCustom(color: Color(0xfff0f0f6)),
          // _tabBtn(
          //     text: '이용약관(추천유저보기)',
          //     onTap: () {
          //       Navigator.pushNamed(context, "/voiceMain");
          //     }),
          HorizontalDividerCustom(
              thickness: getProportionateScreenHeight(8),
              color: const Color(0xfff0f0f6)),
          VerticalSpacing(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Text(
              '설정',
              style: TextStyle(
                  color: Color(0xff767676),
                  fontSize: resizeFont(14),
                  fontWeight: FontWeight.w500),
            ),
          ),
          // VerticalSpacing(of: 10),
          _tabBtn(
              text: '로그아웃',
              onTap: () {
                AuthService.logout(context);
              }),
          const HorizontalDividerCustom(color: Color(0xfff0f0f6)),
          _tabBtn(
              text: '테스트 설정',
              onTap: () {
                Navigator.pushNamed(context, "/dummy");
              }),
        ]);
  }

  Widget _tabBtn({required String text, required GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(20)),
        child: Row(
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: resizeFont(16),
                    color: Color(0xff111111),
                    fontWeight: FontWeight.w400)),
            const Spacer(),
            const Icon(Icons.chevron_right_outlined)
          ],
        ),
      ),
    );
  }
}
