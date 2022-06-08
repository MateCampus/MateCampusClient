import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

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
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(10),
        right: getProportionateScreenWidth(20),
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
        children: [
          widget.vm.pickedImgs.isEmpty ? const SizedBox() : _showLoadImage(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.image_outlined,
                  color: Colors.grey,
                  size: getProportionateScreenWidth(25),
                ),
                onPressed: () {
                  widget.vm.getImageFromGallery();
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
                  widget.vm.getImageFromCamera();
                },
              ),
              const Spacer(),
              Checkbox(
                value: widget.vm.isShowOnlySameUniv,
                onChanged: (value) {
                  widget.vm.changeIsShowOnlySameUniv();
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
                    color:
                        widget.vm.isShowOnlySameUniv ? mainColor : Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _showLoadImage() {
    return Padding(
      padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20)),
      child: SizedBox(
        height: getProportionateScreenHeight(100),
        child: ListView.builder(
            itemCount: widget.vm.pickedImgs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                    child: Image.file(
                      File(widget.vm.pickedImgs[index].path),
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
                        widget.vm.removeImage(index);
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
