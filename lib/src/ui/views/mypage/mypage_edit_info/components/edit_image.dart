import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class EditImage extends StatefulWidget {
  MypageViewModel vm;
  EditImage({Key? key, required this.vm}) : super(key: key);

  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(160),
        height: getProportionateScreenHeight(160),
        child: Stack(
          alignment: Alignment.center,
          children: [
            (Platform.isAndroid)
                ? Container(
                    height: getProportionateScreenHeight(140),
                    width: getProportionateScreenWidth(140),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffe5e5ec)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: (widget.vm.changedProfileImgPath == '')
                        ? Image(
                            image: CachedNetworkImageProvider(
                                widget.vm.myInfo.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(widget.vm.changedProfileImgPath),
                            fit: BoxFit.cover,
                          ))
                : CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: getProportionateScreenHeight(70),
                    backgroundImage: (widget.vm.changedProfileImgPath.isEmpty)
                        ? widget.vm.myInfo.imageUrl.startsWith('https')
                            ? CachedNetworkImageProvider(
                                widget.vm.myInfo.imageUrl) as ImageProvider
                            : AssetImage(widget.vm.myInfo.imageUrl)
                        : widget.vm.changedProfileImgPath.startsWith('https')
                            ? CachedNetworkImageProvider(
                                widget.vm.changedProfileImgPath) as ImageProvider
                            : AssetImage(widget.vm.changedProfileImgPath)),
            (Platform.isAndroid)
            ? Positioned(
                bottom: getProportionateScreenHeight(5),
                right: getProportionateScreenWidth(3),
                child: InkWell(
                  onTap: () {
                    widget.vm.getProfileImgFromGallery();
                  },
                  child: Container(
                    width: getProportionateScreenWidth(37),
                    height: getProportionateScreenHeight(37),
                    decoration: BoxDecoration(
                      color: kMainColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white,
                          width: getProportionateScreenWidth(3),
                          style: BorderStyle.solid),
                    ),
                    child: Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                      size: getProportionateScreenHeight(15),
                    ),
                  ),
                ))
            :
            Positioned(
                bottom: getProportionateScreenHeight(15),
                right: getProportionateScreenWidth(10),
                child: InkWell(
                  onTap: () {
                    widget.vm.getProfileImgFromGallery();
                  },
                  child: Container(
                    width: getProportionateScreenWidth(37),
                    height: getProportionateScreenHeight(37),
                    decoration: BoxDecoration(
                      color: kMainColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                          style: BorderStyle.solid),
                    ),
                    child: Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                      size: getProportionateScreenHeight(15),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
