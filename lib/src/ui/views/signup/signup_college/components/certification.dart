import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';

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
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: const Text(
              '학생증 인증',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showBottomSheet(context);
            },
            child: Container(
                height: getProportionateScreenHeight(170),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: screenBackgroundColor,
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
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: const Text('인증은 최대 24시간이 소요될 수 있습니다'),
          )
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return Container(
            height: getProportionateScreenHeight(150),
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("갤러리에서 사진 가져오기"),
                  onTap: () {
                    vm.getStudentIdCardFromGallery(context);
                  },
                ),
                const HorizontalDividerCustom(),
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("카메라로 사진 찍기"),
                  onTap: () {
                    vm.getStudentIdCardFromCamera(context);
                  },
                )
              ],
            ),
          );
        });
  }
}
