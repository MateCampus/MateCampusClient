// import 'package:flutter/material.dart';
// import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
// import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
// import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
// import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
// import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
// import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
// import 'package:zamongcampus/src/config/size_config.dart';
// import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
// import 'package:zamongcampus/src/ui/common_widgets/round_chip.dart';

// class VoiceRoomTextChatMessage extends StatelessWidget {
//   final ChatMessage message;
//   final VoiceDetailViewModel vm;
//   const VoiceRoomTextChatMessage(
//       {Key? key, required this.message, required this.vm})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: getProportionateScreenWidth(15),
//           vertical: getProportionateScreenHeight(5)),
//       child: (message.type == "ENTER" || message.text == "EXIT") //얘는 뭔지 모르겟다
//           ? Container(
//               alignment: Alignment.center,
//               child: RoundChip(
//                 text: message.text,
//                 textColor: Colors.white,
//                 backgroundColor: Colors.black38,
//                 horizontalPadding: 10,
//                 verticalPadding: 3.5,
//                 fontsize: 11,
//               ))
//           : Row(
//               crossAxisAlignment: message.loginId == AuthService.loginId
//                   ? CrossAxisAlignment.end
//                   : CrossAxisAlignment.start,
//               mainAxisAlignment: message.loginId == AuthService.loginId
//                   ? MainAxisAlignment.end
//                   : MainAxisAlignment.start,
//               children: [
//                 if (message.loginId != AuthService.loginId) ...[
//                   Padding(
//                       padding:
//                           EdgeInsets.only(top: getProportionateScreenHeight(3)),
//                       child: Container()

//                       // CircleAvatar(
//                       //   backgroundColor: Colors.grey,
//                       //   radius: getProportionateScreenWidth(17),
//                       //   backgroundImage:
//                       //       // TODO: aws 적용 부분
//                       //       // Image.network(message.imageUrl).image,
//                       //       // loginIdToImageUrl(message.loginId),
//                       //       loginIdToImageUrl(message.loginId).startsWith('https')
//                       //           ? CachedNetworkImageProvider(
//                       //                   loginIdToImageUrl(message.loginId))
//                       //               as ImageProvider
//                       //           : const AssetImage(
//                       //               'assets/images/user/general_user.png'),
//                       // ),
//                       ),
//                   const HorizontalSpacing(of: 8),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             bottom: getProportionateScreenHeight(5),
//                             left: getProportionateScreenWidth(3)),
//                         child: Text(
//                           // ** nickname으로 변경한 부분
//                           //loginIdToNickname(message.loginId),
//                           message.loginId,
//                           style: TextStyle(
//                               fontSize: resizeFont(12),
//                               color: Colors.grey[800],
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                               constraints: BoxConstraints(
//                                   maxWidth: SizeConfig.screenWidth! * 0.6),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: getProportionateScreenWidth(10),
//                                   vertical: getProportionateScreenHeight(8)),
//                               decoration: const BoxDecoration(
//                                 color: kMainColor, //컬러바꾸기
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                     bottomRight: Radius.circular(10)),
//                               ),
//                               child: Text(
//                                 message.text,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: resizeFont(15),
//                                     height: 1.2),
//                               )),
//                           const HorizontalSpacing(of: 5),
//                           Text(
//                             dateToTime(message.createdAt),
//                             style: TextStyle(
//                                 fontSize: kCreateAtFontSize,
//                                 color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//                 if (message.loginId == AuthService.loginId) ...[
//                   //내 메세지
//                   Text(
//                     dateToTime(message.createdAt),
//                     style: TextStyle(
//                         fontSize: kCreateAtFontSize, color: Colors.grey),
//                   ),
//                   const HorizontalSpacing(of: 5),
//                   Container(
//                     constraints:
//                         BoxConstraints(maxWidth: SizeConfig.screenWidth! * 0.7),
//                     padding: EdgeInsets.symmetric(
//                         horizontal: getProportionateScreenWidth(10),
//                         vertical: getProportionateScreenHeight(8)),
//                     decoration: const BoxDecoration(
//                         color: Color(0xffFFE8D8), //컬러체인지해야함
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10),
//                             bottomLeft: Radius.circular(10))),
//                     child: Text(
//                       message.text,
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: resizeFont(15),
//                           height: 1.2),
//                     ),
//                   )
//                 ],
//               ],
//             ),
//     );
//   }
//   //  String loginIdToNickname(String loginId) {
//   //   return vm.chatMemberInfos[loginId].nickname;
//   // }

//   // String loginIdToImageUrl(String loginId) {
//   //   return vm.chatMemberInfos[loginId].imageUrl;
//   // }
// }
