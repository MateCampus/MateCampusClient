import 'package:cached_network_image/cached_network_image.dart';
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
      child: Stack(
        children: [
          CircleAvatar(
              radius: getProportionateScreenHeight(50),
              backgroundImage: (widget.vm.changedProfileImgPath.isEmpty)
                  ? widget.vm.myInfo.imageUrl.startsWith('https')
                      ? CachedNetworkImageProvider(widget.vm.myInfo.imageUrl)
                          as ImageProvider
                      : AssetImage(widget.vm.myInfo.imageUrl)
                  : widget.vm.changedProfileImgPath.startsWith('https')
                      ? CachedNetworkImageProvider(
                          widget.vm.changedProfileImgPath) as ImageProvider
                      : AssetImage(widget.vm.changedProfileImgPath)),
          Positioned(
              bottom: 1,
              right: -1,
              child: InkWell(
                onTap: () {
                  widget.vm.getProfileImgFromGallery();
                },
                child: Container(
                  width: getProportionateScreenWidth(30),
                  height: getProportionateScreenHeight(30),
                  decoration: BoxDecoration(
                    color: kMainColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white,
                        width: 3.0,
                        style: BorderStyle.solid),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: getProportionateScreenHeight(15),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
