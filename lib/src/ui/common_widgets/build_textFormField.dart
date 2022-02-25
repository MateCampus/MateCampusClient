import 'package:flutter/material.dart';

import '../../business_logic/utils/constants.dart';

class BuildTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const BuildTextFormField({Key? key, this.hint = "", required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        // labelText: "이벤트명",
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor),
        ),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: mainColor)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      ),
    );
  }
}
