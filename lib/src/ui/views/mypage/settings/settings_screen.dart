import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/views/mypage/settings/components/body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return Scaffold(
      appBar: SubAppbar(
        titleText: '설정',
        isCenter: true,
      ),
      backgroundColor: Colors.white,
      body: const Body(),
    );
  }
}
