import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';

class CollegeListTile extends StatelessWidget {
  final SignUpViewModel vm;
  final int index;
  const CollegeListTile({Key? key, required this.vm, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        vm.selectCollege(context, vm.searchingColleges[index]);
        vm.removeCollegeOverlay();
      },
      dense: true,
      title: Text(
        vm.searchingColleges[index],
        style:
            TextStyle(color: Colors.black87, fontSize: kTextFieldInnerFontSize),
      ),
    );
  }
}
