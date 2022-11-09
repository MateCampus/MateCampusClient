import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/user_profile_bottom_sheet_component/user_profile_bottom_sheet.dart';
import 'package:zamongcampus/src/ui/common_widgets/circle_image_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/round_chip.dart';

class Message extends StatelessWidget {
  final ChatMessage message;
  final vm;
  const Message({Key? key, required this.message, required this.vm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenHeight(5)),
      child: (message.type == "ENTER" || message.text == "EXIT") //얘는 뭔지 모르겟다
          ? Container(
              alignment: Alignment.center,
              child: RoundChip(
                text: message.text,
                textColor: Colors.white,
                backgroundColor: Colors.black38,
                horizontalPadding: 10,
                verticalPadding: 3.5,
                fontsize: 11,
              ))
          : Row(
              crossAxisAlignment: message.loginId == AuthService.loginId
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisAlignment: message.loginId == AuthService.loginId
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                if (message.loginId != AuthService.loginId) ...[
                  CircleImageBtn(
                      imageUrl: loginIdToImageUrl(message.loginId),
                      press: () {
                        showCustomModalBottomSheet(
                            context: context,
                            buildWidget: UserProfileBottomSheet(
                              loginId: message.loginId,
                              bottomBtn: false,
                            ));
                      },
                      size: getProportionateScreenWidth(35)),
                  const HorizontalSpacing(of: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: getProportionateScreenHeight(5),
                            left: getProportionateScreenWidth(3)),
                        child: Text(
                          // ** nickname으로 변경한 부분
                          loginIdToNickname(message.loginId),
                          style: TextStyle(
                              fontSize: resizeFont(12),
                              color: Color(0xff111111),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                  maxWidth: SizeConfig.screenWidth! * 0.6),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(10),
                                  vertical: getProportionateScreenHeight(8)),
                              decoration: const BoxDecoration(
                                color: Colors.white, //컬러바꾸기
                                borderRadius: BorderRadius.only(
                                    // topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Text(
                                message.text,
                                style: TextStyle(
                                    color: Color(0xff111111),
                                    fontSize: resizeFont(14),
                                    height: 1.2),
                              )),
                          const HorizontalSpacing(of: 5),
                          Text(
                            dateToTime(message.createdAt),
                            style: TextStyle(
                                fontSize: kCreateAtFontSize,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                if (message.loginId == AuthService.loginId) ...[
                  //내 메세지
                  Text(
                    dateToTime(message.createdAt),
                    style: TextStyle(
                        fontSize: kCreateAtFontSize, color: Colors.grey),
                  ),
                  const HorizontalSpacing(of: 5),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: SizeConfig.screenWidth! * 0.7),
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                        vertical: getProportionateScreenHeight(8)),
                    decoration: const BoxDecoration(
                        color: kMainColor, //컬러체인지해야함
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: Text(
                      message.text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: resizeFont(14),
                          height: 1.2),
                    ),
                  )
                ],
              ],
            ),
    );
  }

  String loginIdToNickname(String loginId) {
    return vm.chatMemberInfos[loginId].nickname;
  }

  String loginIdToImageUrl(String loginId) {
    return vm.chatMemberInfos[loginId].imageUrl ??
        "assets/images/user/general_user.png";
  }
}
