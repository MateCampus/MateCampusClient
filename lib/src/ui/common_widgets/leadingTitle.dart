import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import 'horizontal_spacing.dart';

class LeadingTitle extends StatelessWidget {
  final String title;
  final double? bottomPadding;
  const LeadingTitle({Key? key, required this.title, this.bottomPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, bottomPadding ?? 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/element/orangeicon.png"),
            const HorizontalSpacing(of: 5),
            Text(
              title,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(17),
                  fontFamily: "SCDream5",
                  color: Color(0xff363636)),
            ),
          ]),
    );
  }
}
