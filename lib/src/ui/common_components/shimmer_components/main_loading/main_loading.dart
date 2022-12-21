import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/main_appbar_components/main_appbar.dart';
import 'package:zamongcampus/src/ui/common_components/shimmer_components/main_loading/components/main_loading_list_tile.dart';

class MainLoadingPage extends StatefulWidget {
  const MainLoadingPage({Key? key}) : super(key: key);

  @override
  State<MainLoadingPage> createState() => _MainLoadingPageState();
}

class _MainLoadingPageState extends State<MainLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        titleText: "피드",
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.bell,
            ),
            iconSize: kAppBarIconSizeFA,
            color: kAppBarIconColor,
          )
        ],
      ),
      backgroundColor: kMainScreenBackgroundColor,
      body: SingleChildScrollView(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(40)),
                    const MainLoadingListTile(),
                  ],
                )),
      ),
    );
  }
}
