// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
// import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
// import 'package:zamongcampus/src/config/size_config.dart';
// import 'package:zamongcampus/src/ui/common_components/voice_room_chat_bottom_sheet_component/components/test_list_tile.dart';
// import 'package:zamongcampus/src/ui/common_components/voice_room_chat_bottom_sheet_component/components/voice_room_textchat_input_field.dart';
// import 'package:zamongcampus/src/ui/common_components/voice_room_chat_bottom_sheet_component/components/voice_room_textchat_message.dart';
// import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
// import 'package:zamongcampus/src/ui/common_widgets/custom_drag_bar.dart';
// import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';

// class VoiceRoomChatBottomSheet extends StatefulWidget {
//   final VoiceDetailViewModel vm;
//   const VoiceRoomChatBottomSheet({Key? key, required this.vm})
//       : super(key: key);

//   @override
//   _VoiceRoomChatBottomSheetState createState() =>
//       _VoiceRoomChatBottomSheetState();
// }

// class _VoiceRoomChatBottomSheetState extends State<VoiceRoomChatBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context: context);
//     final MediaQueryData mediaQueryData = MediaQuery.of(context);

//     return ChangeNotifierProvider.value(
//       value: widget.vm,
//       child: Consumer<VoiceDetailViewModel>(
//         builder: (context, value, child) {
//           return makeDismissible(
//               child: Padding(
//             padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
//             child: DraggableScrollableSheet(
//               initialChildSize: 0.5,
//               maxChildSize: 0.8,
//               builder:
//                   (BuildContext context, ScrollController scrollController) =>
//                       Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(25)),
//                     boxShadow: [kDefaultShadowOnlyTop]),
//                 child: widget.vm.busy
//                     ? const IsLoading()
//                     : Column(
//                         children: [
//                           const CustomDragBar(),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: getProportionateScreenWidth(5),
//                               ),
//                               child: Container(
//                                 alignment: Alignment.bottomCenter,
//                                 child: ListView.builder(
//                                     controller: scrollController,
//                                     physics: ClampingScrollPhysics(),
//                                     shrinkWrap: true,
//                                     reverse: true,
//                                     itemCount:
//                                         widget.vm.textChatMessages.length,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       return VoiceRoomTextChatMessage(
//                                           message:
//                                               widget.vm.textChatMessages[index],
//                                           vm: widget.vm);
//                                     }),
//                               ),
//                             ),
//                           ),
//                           SafeArea(
//                               child: BottomFixedBtnDecoBox(
//                                   child: VoiceRoomTextChatInputField(
//                                       vm: widget.vm)))
//                         ],
//                       ),
//               ),
//             ),
//           ));
//         },
//       ),
//     );
//   }

//   Widget makeDismissible({required Widget child}) => GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () => Navigator.of(context).pop(),
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: child,
//         ),
//       );
// }
