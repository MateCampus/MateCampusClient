// import 'package:zamongcampus/config/size_config.dart';
// import 'package:zamongcampus/constants.dart';
// import 'package:zamongcampus/controller/chat/chat_controller.dart';
// import 'package:zamongcampus/controller/home_controller.dart';
// import 'package:zamongcampus/methods.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CommonAppbar extends StatelessWidget with PreferredSizeWidget {
//   const CommonAppbar(
//       {Key key,
//       @required this.appBar,
//       this.title,
//       this.bottom,
//       this.height,
//       this.titleSize})
//       : super(key: key);
//   final String title;
//   final PreferredSize bottom;
//   final AppBar appBar;
//   final double height;
//   final double titleSize;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         title ?? "",
//         style: TextStyle(
//             color: Colors.white,
//             fontSize: titleSize ?? getProportionateScreenHeight(25),
//             letterSpacing: 3,
//             fontFamily: "SCDream4"),
//       ),
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [subColor, mainColor],
//             stops: [0.5, 1.0],
//           ),
//         ),
//       ),
//       brightness: Brightness.dark,
//       centerTitle: true,
//       actions: <Widget>[
//         Row(
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.people),
//               color: Colors.white,
//               onPressed: () {
//                 // 추후 반드시 삭제 (local db 확인 용)
//                 Get.toNamed("/DummyScreen");
//               },
//             ),
//             SizedBox(width: getProportionateScreenWidth(2)),
//             IconButton(
//               icon: Icon(Icons.notifications_outlined),
//               color: Colors.white,
//               onPressed: () {
//                 Get.toNamed("/Notifications");
//               },
//             )
//           ],
//         ),
//       ],
//       leading: IconButton(
//         icon: Icon(Icons.menu),
//         color: Colors.white,
//         onPressed: () {
//           HomeController.to.drawerKey.currentState.openDrawer();
//         },
//       ),
//       bottom: bottom ?? null,
//     );
//   }

//   @override
//   Size get preferredSize =>
//       Size.fromHeight(height ?? appBar.preferredSize.height);
// }
