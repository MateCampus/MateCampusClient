import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
                fit: StackFit.expand,
                children: [
                  postImageItem.resource.startsWith('https')
                      ? CachedNetworkImage(
                          width: 60,
                          height: 60,
                          imageUrl: postImageItem.resource,
                          colorBlendMode: BlendMode.dstATop,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Image.asset(
                          postImageItem.resource,
                          fit: BoxFit.cover,
                          color: Colors.grey.withOpacity(0.6),
                          colorBlendMode: BlendMode.dstATop,
                        ),
                  Center(
                    child: Text(
                      '+' + restImg.toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
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
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
