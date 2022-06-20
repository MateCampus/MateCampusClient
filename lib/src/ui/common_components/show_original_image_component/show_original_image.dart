import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class ShowOriginalImage extends StatelessWidget {
  final String imageUrl;
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  const ShowOriginalImage(
      {Key? key,
      required this.imageUrl,
      this.loadingBuilder,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            builder: _buildItem,
            itemCount: 1,
            loadingBuilder: loadingBuilder,
          ),
          Positioned(
            top: getProportionateScreenHeight(50),
            right: getProportionateScreenWidth(5),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: imageUrl.startsWith('https')
          ? CachedNetworkImageProvider(imageUrl) as ImageProvider
          : AssetImage(imageUrl),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
    );
  }
}
