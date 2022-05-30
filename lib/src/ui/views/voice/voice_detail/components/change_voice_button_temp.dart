import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class ChangeVoiceBtn extends StatelessWidget {
  final VoiceDetailViewModel vm;
  const ChangeVoiceBtn({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              vm.setOriginalVoice();
            },
            child: const Text('내 목소리'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: subColor),
          ),
          TextButton(
            onPressed: () {
              vm.setVoiceFilter1();
            },
            child: const Text('아기 목소리'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: mainColor),
          ),
          TextButton(
            onPressed: () {
              vm.setVoiceFilter2();
            },
            child: const Text('괴물 목소리'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: mainColor),
          ),
          TextButton(
            onPressed: () {
              vm.setVoiceFilter3();
            },
            child: const Text('???목소리'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: mainColor),
          ),
        ],
      ),
    );
  }
}
