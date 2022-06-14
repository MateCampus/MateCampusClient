import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class FixedBottomBar extends StatefulWidget {
  PostCreateScreenViewModel vm;
  FixedBottomBar({Key? key, required this.vm}) : super(key: key);

  @override
  _FixedBottomBarState createState() => _FixedBottomBarState();
}

//List<XFile> get pickedIgms => _pickedImgs;

class _FixedBottomBarState extends State<FixedBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //하단의 아이콘 버튼의 패딩값 때문에 여기서는 양 옆을 다르게 패딩값을 줘야한다.(+vertical패딩값도 필요없음)
      //그래서 BottomFixedBtnDecoBox안쓰고 여기서 바로 custom해서 씀
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: Offset(0, -getProportionateScreenHeight(5)),
              blurRadius: 3,
              blurStyle: BlurStyle.normal)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.vm.pickedImgs.isEmpty ? const SizedBox() : _showLoadImage(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    widget.vm.getImageFromGallery(context);
                  },
                  icon: Icon(
                    CupertinoIcons.photo,
                    color: postColor,
                    size: getProportionateScreenWidth(20),
                  ),
                  label: Text(
                    widget.vm.pickedImgs.length.toString() + '/10',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(13),
                        color: postColor),
                  )),
              IconButton(
                icon: Icon(
                  CupertinoIcons.camera,
                  color: postColor,
                  size: getProportionateScreenWidth(20),
                ),
                onPressed: () {
                  widget.vm.getImageFromCamera(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showLoadImage() {
    return SizedBox(
      height: getProportionateScreenHeight(100),
      child: ListView.builder(
          itemCount: widget.vm.pickedImgs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              Stack(alignment: AlignmentDirectional.center, children: [
                Container(
                  height: getProportionateScreenHeight(92),
                  width: getProportionateScreenWidth(92),
                  padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                  child: Image.file(
                    File(widget.vm.pickedImgs[index].path),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: getProportionateScreenWidth(0),
                    top: getProportionateScreenHeight(0),
                    child: IconButton(
                      padding: EdgeInsets.zero, // 패딩 설정
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        CupertinoIcons.xmark_circle,
                        color: Colors.white,
                        size: getProportionateScreenWidth(20),
                      ),
                      onPressed: () {
                        widget.vm.removeImage(index);
                      },
                    )),
                Positioned(
                    right: getProportionateScreenWidth(0),
                    top: getProportionateScreenHeight(0),
                    child: IconButton(
                      padding: EdgeInsets.zero, // 패딩 설정
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.black,
                        size: getProportionateScreenWidth(20),
                      ),
                      onPressed: () {
                        widget.vm.removeImage(index);
                      },
                    ))
              ])),
    );
  }
}
