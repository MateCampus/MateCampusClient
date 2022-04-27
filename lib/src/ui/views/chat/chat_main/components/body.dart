import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.grey.shade100,
          elevation: 4.0,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              radius: getProportionateScreenHeight(30),
              backgroundImage:
                  const AssetImage('assets/images/user/general_user.png'),
            ),
            title: const Text('내 친구'),
            trailing: const Icon(
              Icons.chevron_right_outlined,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            onTap: () {
              Navigator.pushNamed(context, "/friend");
            },
          ),
        )
      ],
    );
  }
}
