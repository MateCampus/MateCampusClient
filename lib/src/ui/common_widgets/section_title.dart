// import 'package:zamongcampus/constants.dart';
// import 'package:zamongcampus/config/size_config.dart';
// import 'package:flutter/material.dart';

// class SectionTitle extends StatelessWidget {
//   const SectionTitle(
//       {Key key,
//       @required this.title,
//       this.press,
//       this.isNotIncludeAllView,
//       this.paddingValue})
//       : super(key: key);

//   final String title;
//   final GestureTapCallback press;
//   final bool isNotIncludeAllView;
//   final double paddingValue;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: getProportionateScreenWidth(paddingValue ?? kDefaultPadding),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontFamily: "SCDream6",
//               letterSpacing: 1.0,
//               fontSize: getProportionateScreenWidth(16),
//             ),
//           ),
//           isNotIncludeAllView == null
//               ? Container(
//                   height: getProportionateScreenHeight(40),
//                   // child: TextButton(
//                   //     style: TextButton.styleFrom(
//                   //       primary: kPrimaryColor,
//                   //     ),
//                   //     onPressed: press ?? () {},
//                   //     child: Text(
//                   //       "전체보기",
//                   //       style: TextStyle(color: kPrimaryColor),
//                   //     )),
//                   child: TextButton(
//                       onPressed: press ?? () {},
//                       child: Row(
//                         children: [
//                           Text(
//                             "더보기",
//                             style: TextStyle(
//                                 fontSize: getProportionateScreenWidth(13),
//                                 color: Colors.black87),
//                           ),
//                           Icon(
//                             Icons.chevron_right,
//                             size: getProportionateScreenWidth(20),
//                             color: Colors.black87,
//                           ),
//                         ],
//                       )),
//                 )
//               : Container(
//                   height: getProportionateScreenHeight(40),
//                 )
//         ],
//       ),
//     );
//   }
// }
