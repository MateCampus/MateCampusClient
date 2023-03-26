import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/shimmer_box.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class MainLoadingListTile extends StatelessWidget {
  const MainLoadingListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: ShimmerBox(
              width: getProportionateScreenWidth(40),
              height: getProportionateScreenHeight(40),
              boxShape: BoxShape.circle,
            ),
            title: ShimmerBox(
              height: getProportionateScreenHeight(15),
              width: getProportionateScreenWidth(35),
            ),
            subtitle: ShimmerBox(
              height: getProportionateScreenHeight(15),
              width: getProportionateScreenWidth(60),
            ),
          ),
          ShimmerBox(
            height: getProportionateScreenHeight(80),
          ),
          const VerticalSpacing()
        ],
      ),
    );
  }
}
