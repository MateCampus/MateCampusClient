// import 'package:zamongcampus/constants.dart';
// import 'package:flutter/material.dart';

// class RoundChip extends StatelessWidget {
//   final String text;
//   final Color backgroundColor;
//   final Color textColor;
//   final double horizontalPadding;
//   final double verticalPadding;
//   final double fontsize;

//   const RoundChip(
//       {Key? key,
//       this.text,
//       this.backgroundColor,
//       this.textColor,
//       this.horizontalPadding,
//       this.verticalPadding,
//       this.fontsize})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           alignment: Alignment.center,
//           padding: EdgeInsets.symmetric(
//             horizontal: horizontalPadding ?? (kDefaultPadding / 2),
//             vertical: verticalPadding ??
//                 kDefaultPadding / 4, // 5 padding top and bottom
//           ),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20), color: backgroundColor),
//           child: Text(
//             this.text,
//             style: TextStyle(color: this.textColor, fontSize: fontsize ?? 13),
//           ),
//         ),
//       ],
//     );
//   }
// }
