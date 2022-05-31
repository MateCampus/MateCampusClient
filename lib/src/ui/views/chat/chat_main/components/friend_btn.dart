import 'package:flutter/material.dart';
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
          const Text(
            '친구',
            style: TextStyle(fontSize: 12, color: Colors.black87),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
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
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10)),
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
