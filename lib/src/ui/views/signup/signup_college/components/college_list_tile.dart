import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';

class CollegeListTile extends StatelessWidget {
  final SignUpViewModel vm;
  final CollegePresentation college;
  const CollegeListTile({Key? key, required this.vm, required this.college})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        vm.selectCollege(context, college);
        vm.removeCollegeOverlay();
      },
      dense: true,
      title: Text(
        college.collegeName +" ("+college.campusName+")",
        style:
            TextStyle(color: Colors.black87, fontSize: kTextFieldInnerFontSize),
      ),
    );
  }
}
