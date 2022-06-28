import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';

class MajorListTile extends StatelessWidget {
  final SignUpViewModel vm;
  final int index;
  const MajorListTile({Key? key, required this.vm, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        vm.selectMajor(context, vm.searchingMajors[index]);
        vm.removeMajorOverlay();
      },
      dense: true,
      title: Text(
        vm.searchingMajors[index],
        style:
            TextStyle(color: Colors.black87, fontSize: kTextFieldInnerFontSize),
      ),
    );
  }
}
