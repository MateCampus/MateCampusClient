import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class CreatePublicVoiceRoomBtn extends StatelessWidget {
  const CreatePublicVoiceRoomBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/publicVoiceCreate");
      },
      child: SizedBox(
        height: getProportionateScreenHeight(120),
        width: getProportionateScreenWidth(130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: getProportionateScreenHeight(70),
              width: getProportionateScreenWidth(70),
              decoration: const BoxDecoration(
                  color: kMainColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                    )
                  ]),
              child: Icon(
                CupertinoIcons.chat_bubble_2,
                color: Colors.white,
                size: getProportionateScreenHeight(30),
              ),
            ),
            const Spacer(),
            Text(
              '공개 대화방',
              style: TextStyle(
                  fontSize: kPlainTextFontSize, fontWeight: FontWeight.w700),
            ),
            const VerticalSpacing(of: 2),
            Text(
              '누구나 참여 가능',
              style: TextStyle(
                  fontSize: getProportionateScreenHeight(13),
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}
