import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class FriendBtn extends StatelessWidget {
  const FriendBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '친구',
            style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
          ),
          const VerticalSpacing(of: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/friend");
            },
            child: Container(
              //그림자 효과위해서 쓴다
              //height: getProportionateScreenHeight(76),
              //width: getProportionateScreenWidth(335),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [kShadowForTile],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: getProportionateScreenHeight(25),
                  child: Image.asset(
                    'assets/images/temp/zamonglogo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: const Text(
                  '내 친구',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(
                  Icons.chevron_right_outlined,
                ),
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenHeight(5)),
                onTap: () {
                  Navigator.pushNamed(context, "/friend");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
