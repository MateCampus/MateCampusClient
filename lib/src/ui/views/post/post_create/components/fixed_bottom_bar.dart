import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class FixedBottomBar extends StatefulWidget {
  const FixedBottomBar({Key? key}) : super(key: key);

  @override
  _FixedBottomBarState createState() => _FixedBottomBarState();
}

bool _isChecked = false;
List<XFile> _pickedImgs = [];
final ImagePicker _picker = ImagePicker();

//List<XFile> get pickedIgms => _pickedImgs;

class _FixedBottomBarState extends State<FixedBottomBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultShadowBox(
      child: Padding(
        padding: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
        child: Column(
          children: [
            _pickedImgs.isEmpty ? const SizedBox() : _showLoadImage(),
            Padding(
              padding: EdgeInsets.only(
                  right: getProportionateScreenWidth(10),
                  left: getProportionateScreenWidth(10)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: getProportionateScreenWidth(25),
                    ),
                    onPressed: () {
                      getImageFromGallery();
                    },
                  ),
                  const HorizontalSpacing(of: 5),
                  IconButton(
                    icon: Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.grey,
                      size: getProportionateScreenWidth(25),
                    ),
                    onPressed: () {
                      getImageFromCamera();
                    },
                  ),
                  const Spacer(),
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    activeColor: mainColor,
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.7,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Text(
                    '같은 학교만 보여주기',
                    style: TextStyle(
                        fontSize: 13,
                        color: _isChecked ? mainColor : Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//갤러리에서 이미지 가져오는 함수
  void getImageFromGallery() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;
      });
    }
  }

  //카메라에서 이미지 가져오는 함수
  void getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _pickedImgs.add(image);
      });
    }
  }

  //이미지 삭제 함수
  void removeImage(int index) {
    setState(() {
      _pickedImgs.removeAt(index);
    });
  }

  Widget _showLoadImage() {
    return Padding(
      padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20)),
      child: SizedBox(
        height: getProportionateScreenHeight(100),
        child: ListView.builder(
            itemCount: _pickedImgs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                    child: Image.file(
                      File(_pickedImgs[index].path),
                      height: getProportionateScreenHeight(90),
                      width: getProportionateScreenWidth(90),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0.1,
                    top: 0.1,
                    child: InkWell(
                      onTap: (() {
                        removeImage(index);
                      }),
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}
