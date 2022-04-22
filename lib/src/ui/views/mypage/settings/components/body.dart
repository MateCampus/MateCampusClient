import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: getProportionateScreenWidth(20)),
      child: Column(children: [
        _tabBtn(text: '계정정보', onTap: () {}),
        const HorizontalDividerCustom(),
        _tabBtn(text: '내 학과 설정', onTap: () {}),
        const HorizontalDividerCustom(),
        _tabBtn(text: '알림 설정', onTap: () {}),
        const HorizontalDividerCustom(),
        _tabBtn(text: '로그아웃', onTap: () {}),
        const HorizontalDividerCustom(),
      ]),
    );
  }

  Widget _tabBtn({required String text, required GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: getProportionateScreenHeight(60),
        width: getProportionateScreenWidth(335),
        child: Row(
          children: [
            Text(text,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.chevron_right_outlined)
          ],
        ),
      ),
    );
  }
}
