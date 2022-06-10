import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class PostImageItemThumbnail extends StatelessWidget {
  const PostImageItemThumbnail(
      {Key? key,
      required this.postImageItem,
      required this.onTap,
      this.hasMoreImg = false,
      this.restImg = 0})
      : super(key: key);

  final ImageItem postImageItem;
  final bool hasMoreImg;
  final GestureTapCallback onTap;
  final int restImg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: postImageItem.id,
        child: hasMoreImg
            ? Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  postImageItem.resource.startsWith('https')
                      ? CachedNetworkImage(
                          imageUrl: postImageItem.resource,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.4),
                                    BlendMode.darken),
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Image.asset(
                          postImageItem.resource,
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.4),
                          colorBlendMode: BlendMode.darken,
                        ),
                  Text(
                    '+' + restImg.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(30),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            : (postImageItem.resource.startsWith('https')
                ? CachedNetworkImage(
                    imageUrl: postImageItem.resource,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.asset(
                    postImageItem.resource,
                    fit: BoxFit.cover,
                  )),
      ),
    );
  }
}

class ImageItem {
  ImageItem({
    required this.id,
    required this.resource,
  });

  final String id;
  final String resource;
}
