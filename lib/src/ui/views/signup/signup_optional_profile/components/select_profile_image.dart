import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SelectProfileImage extends StatelessWidget {
  final SignUpViewModel vm;
  const SelectProfileImage({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          (Platform.isAndroid)
              ? Container(
                  height: getProportionateScreenHeight(100),
                  width: getProportionateScreenWidth(100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffe5e5ec)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: (vm.userImgPath == '')
                      ? Image.asset(
                          'assets/images/user/general_user.png',
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(vm.userImgPath),
                          fit: BoxFit.cover,
                        ))
              : CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: getProportionateScreenHeight(55),
                  backgroundImage: (vm.userImgPath == '')
                      ? const AssetImage('assets/images/user/general_user.png')
                      : vm.userImgPath.startsWith('https')
                          ? CachedNetworkImageProvider(vm.userImgPath)
                              as ImageProvider
                          : AssetImage(vm.userImgPath)),
          (Platform.isAndroid)?
          Positioned(
              bottom: -getProportionateScreenHeight(0),
              right: getProportionateScreenWidth(100),
              child: InkWell(
                onTap: () {
                  vm.getUserImgFromGallery();
                },
                child: Container(
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenHeight(35),
                  decoration: BoxDecoration(
                    color: kMainColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white,
                        width: getProportionateScreenWidth(4),
                        style: BorderStyle.solid),
                  ),
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: getProportionateScreenHeight(20),
                  ),
                ),
              ))
              : Positioned(
              bottom: getProportionateScreenHeight(0),
              right: getProportionateScreenWidth(110),
              child: InkWell(
                onTap: () {
                  vm.getUserImgFromGallery();
                },
                child: Container(
                  width: getProportionateScreenWidth(35),
                  height: getProportionateScreenHeight(35),
                  decoration: BoxDecoration(
                    color: kMainColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white,
                        width: getProportionateScreenWidth(4),
                        style: BorderStyle.solid),
                  ),
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: getProportionateScreenHeight(20),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
