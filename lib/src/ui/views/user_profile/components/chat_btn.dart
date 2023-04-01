import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_from_friendProfile_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_detail_from_friendProfile/chat_detail_from_friendProfile_screen.dart';

class ChatBtn extends StatefulWidget {
  UserProfileDemandSurveyViewModel vm;
  ChatBtn({Key? key, required this.vm}) : super(key: key);

  @override
  _ChatBtnState createState() => _ChatBtnState();
}

class _ChatBtnState extends State<ChatBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: ElevatedButton.icon(
        icon: const Icon(
          CupertinoIcons.chat_bubble_2,
          color: Colors.white,
        ),
        label: Text('채팅하기',
            style: TextStyle(
                fontSize: resizeFont(16), fontWeight: FontWeight.w700)),
        onPressed: () {
          widget.vm.startChat(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kMainColor,
          minimumSize: Size(getProportionateScreenWidth(254),
              getProportionateScreenHeight(56)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200.0)),
        ),
      ),
    );
  }
}
