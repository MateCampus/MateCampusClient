import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SelectProfileImage extends StatelessWidget {
  final SignUpViewModel vm;
  const SelectProfileImage({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey,
                radius: getProportionateScreenHeight(55),
                backgroundImage: (vm.userImgPath == '')
                    ? const AssetImage('assets/images/user/general_user.png')
                    : vm.userImgPath.startsWith('https')
                        ? CachedNetworkImageProvider(vm.userImgPath)
                            as ImageProvider
                        : AssetImage(vm.userImgPath)),
            Positioned(
                bottom: 1,
                right: -1,
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
                          width: 3.0,
                          style: BorderStyle.solid),
                    ),
                    child: Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                      size: getProportionateScreenHeight(18),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
