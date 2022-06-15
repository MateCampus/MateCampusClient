import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: kHorizontalPadding),
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey.shade100,
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(3),
              horizontal: getProportionateScreenWidth(15)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tabBtn(text: '공지 및 이벤트', onTap: () {}),
                const HorizontalDividerCustom(),
                _tabBtn(text: '고객센터', onTap: () {}),
                const HorizontalDividerCustom(),
                _tabBtn(text: '이용약관', onTap: () {}),
                const HorizontalDividerCustom(),
                _tabBtn(text: '버전정보', version: '최신버전', onTap: () {}),
              ]),
        ),
      ),
    );
  }

  Widget _tabBtn(
      {required String text,
      String? version,
      required GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(305),
        child: Row(
          children: [
            Text(text,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
            const Spacer(),
            version == null
                ? const SizedBox()
                : Text(version,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                    )),
            const Icon(Icons.chevron_right_outlined)
          ],
        ),
      ),
    );
  }
}
