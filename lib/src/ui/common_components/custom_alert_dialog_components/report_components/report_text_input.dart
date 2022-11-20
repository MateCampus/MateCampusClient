import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/report_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class ReportTextInput extends StatelessWidget {
  final ReportViewModel vm;
  const ReportTextInput({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              focusNode: vm.reportFormFocusNode,
              textInputAction: TextInputAction.newline,
              controller: vm.bodyTextController,
              style: TextStyle(fontSize: kTextFieldInnerFontSize),
              // style: TextStyle(fontSize: 150), //테스트용
              // maxLength: 250,
              maxLines: 12,
              minLines: 12, //이걸로 사이즈 조절
              decoration: InputDecoration(
                hintText: "신고 사유를 적어주시면 검토 후 조치하겠습니다",
                hintStyle: TextStyle(
                    color: Colors.black45, fontSize: kTextFieldInnerFontSize),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
