import 'dart:io';

import 'package:flutter/material.dart';
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
              '학교 인증',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: getProportionateScreenHeight(120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text("갤러리에서 사진 가져오기"),
                            onTap: () {
                              vm.getStudentIdCardFromGallery();
                              Navigator.pop(context);
                            },
                          ),
                          HorizontalDividerCustom(),
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text("카메라로 사진 찍기"),
                            onTap: () {
                              vm.getStudentIdCardFromCamera();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Container(
                height: getProportionateScreenHeight(170),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: (vm.studentIdImgPath == '')
                    ? Center(child: Icon(Icons.add))
                    : Image.file(
                        File(vm.studentIdImgPath),
                        fit: BoxFit.cover,
                      )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: Text('학생증 사진을 올려주세요. 인증은 최대 24시간이 소요될 수 있습니다'),
          )
        ],
      ),
    );
  }
}
