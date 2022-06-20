import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import '../../../business_logic/models/enums/categoryCode.dart';

List<CategoryCode> selectCategoryDialog(BuildContext context) {
  SizeConfig().init(context: context);
  List<CategoryCode> selectedCategories = [];
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            child: Container(
              height: SizeConfig.screenHeight! * 0.6,
              child: Column(),
            ),
          ),
        );
      });

  return selectedCategories;
}
