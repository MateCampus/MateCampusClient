import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/components/fixed_bottom_bar.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/components/tag_category.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/components/text_input_space.dart';
import 'package:zamongcampus/src/ui/views/voice/public_voice_create/components/category_select_line.dart';

class Body extends StatelessWidget {
  final PostCreateScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputSpace(vm: vm),
                  CategorySelectLine(vm: vm, from: "post"),
                ],
              ),
            ),
          ),
        ),
        SafeArea(child: FixedBottomBar(vm: vm))
      ],
    );
  }
}
