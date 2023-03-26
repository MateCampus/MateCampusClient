// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:zamongcampus/src/config/size_config.dart';

// class ShowImage extends StatelessWidget {
//   final List<String> images;
//   const ShowImage({Key? key, required this.images}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Widget widget;
//     int restImg = images.length - 2;
//     double imageHeight = getProportionateScreenHeight(175);
//     double imageWidth = getProportionateScreenWidth(355);
//     double splitWidth = getProportionateScreenWidth(174.5);
//     Radius imageRadius = const Radius.circular(5);
//     if (images.length == 1) {
//       widget = SizedBox(
//           width: imageWidth,
//           height: imageHeight,
//           child: ClipRRect(
//             borderRadius: BorderRadius.vertical(top: imageRadius),
//             child: images[0].startsWith('https')
//                 ? CachedNetworkImage(
//                     imageUrl: images[0],
//                     fit: BoxFit.cover,
//                   )
//                 : Image.asset(
//                     images[0],
//                     fit: BoxFit.cover,
//                   ),
//           ));
//     } else if (images.length == 2) {
//       widget = SizedBox(
//         width: imageWidth,
//         height: imageHeight,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//                 width: splitWidth,
//                 height: imageHeight,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(topLeft: imageRadius),
//                   child: images[0].startsWith('https')
//                       ? CachedNetworkImage(
//                           imageUrl: images[0],
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset(
//                           images[0],
//                           fit: BoxFit.cover,
//                         ),
//                 )),
//             const Spacer(),
//             SizedBox(
//                 width: splitWidth,
//                 height: imageHeight,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(topRight: imageRadius),
//                   child: images[1].startsWith('https')
//                       ? CachedNetworkImage(
//                           imageUrl: images[1],
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset(
//                           images[1],
//                           fit: BoxFit.cover,
//                         ),
//                 ))
//           ],
//         ),
//       );
//     } else {
//       widget = SizedBox(
//         width: imageWidth,
//         height: imageHeight,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//                 width: splitWidth,
//                 height: imageHeight,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(topLeft: imageRadius),
//                   child: images[0].startsWith('https')
//                       ? CachedNetworkImage(
//                           imageUrl: images[0],
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset(
//                           images[0],
//                           fit: BoxFit.cover,
//                         ),
//                 )),
//             Stack(alignment: AlignmentDirectional.center, children: [
//               SizedBox(
//                   width: splitWidth,
//                   height: imageHeight,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(topRight: imageRadius),
//                     child: images[1].startsWith('https')
//                         ? CachedNetworkImage(
//                             imageUrl: images[1],
//                             color: Colors.black.withOpacity(0.4),
//                             colorBlendMode: BlendMode.darken,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.asset(
//                             images[1],
//                             color: Colors.black.withOpacity(0.4),
//                             colorBlendMode: BlendMode.darken,
//                             fit: BoxFit.cover,
//                           ),
//                   )),
//               Text(
//                 '+' + restImg.toString(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: getProportionateScreenHeight(30),
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               )
//             ])
//           ],
//         ),
//       );
//     }
//     return widget;
//   }
// }
