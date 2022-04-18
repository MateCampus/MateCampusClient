import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class CreatePrivateVoiceRoomBtn extends StatelessWidget {
  const CreatePrivateVoiceRoomBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/privateVoiceCreate");
      },
      child: SizedBox(
        height: getProportionateScreenHeight(120),
        width: getProportionateScreenWidth(150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: getProportionateScreenHeight(70),
              width: getProportionateScreenWidth(70),
              decoration:
                  const BoxDecoration(color: subColor, shape: BoxShape.circle),
              child: Icon(
                Icons.lock_outlined,
                color: Colors.white,
                size: getProportionateScreenHeight(30),
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            const Text(
              '비밀 대화방',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Text(
              '친구만 참여 가능',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
