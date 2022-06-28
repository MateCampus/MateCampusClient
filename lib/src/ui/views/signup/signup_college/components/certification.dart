import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class Certification extends StatelessWidget {
  final SignUpViewModel vm;
  const Certification({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '학생증 인증',
            style: TextStyle(
                fontSize: kLabelFontSize,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                _selectPhoto(context);
              },
              child: Container(
                  height: getProportionateScreenHeight(200),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kTextFieldColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: (vm.studentIdImgPath == '')
                      ? const Center(
                          child: Icon(
                          Icons.add,
                          color: Color(0xFFADADAD),
                          size: 30,
                        ))
                      : Image.file(
                          File(vm.studentIdImgPath),
                          fit: BoxFit.cover,
                        )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: Text(
              '인증은 최대 24시간이 소요될 수 있습니다',
              style: TextStyle(
                  fontSize: kLabelFontSize,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  _selectPhoto(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      barrierColor: Colors.black54,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            '갤러리에서 사진 가져오기',
            style: TextStyle(
                fontSize: resizeFont(15.0),
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            Navigator.pop(context);
            vm.getStudentIdCardFromGallery(context);
          },
        ),
        BottomSheetAction(
          title: Text(
            '카메라로 사진 찍기',
            style: TextStyle(
                fontSize: resizeFont(15.0),
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            Navigator.pop(context);
            vm.getStudentIdCardFromCamera(context);
          },
        ),
      ],
      cancelAction: CancelAction(
          title: Text(
            '취소',
            style: TextStyle(fontSize: resizeFont(16.0)),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          }),
    );
  }
}
