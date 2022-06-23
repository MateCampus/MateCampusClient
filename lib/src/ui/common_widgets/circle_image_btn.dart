import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImageBtn extends StatelessWidget {
  final String imageUrl;
  final GestureTapCallback press;
  final double size;
  final double? shade;
  const CircleImageBtn(
      {Key? key,
      required this.imageUrl,
      required this.press,
      required this.size,
      this.shade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: shade ?? 0,
      color: Colors.grey,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.black12,
        onTap: press,
        child: Ink.image(
          image: imageUrl.startsWith('https')
              ? CachedNetworkImageProvider(imageUrl) as ImageProvider
              : AssetImage(imageUrl),
          fit: BoxFit.cover,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
