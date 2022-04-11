import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/gallery_photo_view_wrapper.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_image_item_thumbnail.dart';

class PostBody extends StatelessWidget {
  PostDetailScreenViewModel vm;

  PostBody({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(vm.postDetail.body),
        vm.postDetail.imageUrls == null ? Container() : _hasImage(context),
        Row(
          children: [
            InkWell(
              onTap: () {
                vm.likePost(vm.postDetail.loginId, vm.postDetail.id);
              },
              child: vm.isliked
                  ? Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      child: Icon(
                        Icons.favorite,
                        size: getProportionateScreenWidth(22),
                        color: mainColor,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      child: Icon(Icons.favorite_border,
                          size: getProportionateScreenWidth(22)),
                    ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: Text(
                vm.postDetail.likedCount,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: getProportionateScreenWidth(22),
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(40),
              child: Text(
                vm.postDetail.commentCount,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Icon(
                  Icons.bookmark_outline,
                  size: getProportionateScreenWidth(25),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _hasImage(BuildContext context) {
    Widget widget;
    int restImg = vm.postDetail.imageUrls!.length - 3;

    List<ImageItem> postImageItems = <ImageItem>[];
    for (int i = 0; i < vm.postDetail.imageUrls!.length; i++) {
      postImageItems
          .add(ImageItem(id: "tag${i}", resource: vm.postDetail.imageUrls![i]));
    }

    void open(BuildContext context, final int index) {
      //PostImageItemThumbnail의 onTap 함수
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GalleryPhotoViewWrapper(
            imageItems: postImageItems,
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            initialIndex: index,
            scrollDirection: Axis.horizontal,
          ),
        ),
      );
    }

    EdgeInsets margin = EdgeInsets.only(
        top: getProportionateScreenHeight(10),
        bottom: getProportionateScreenHeight(5));
    switch (vm.postDetail.imageUrls!.length) {
      case 1:
        widget = Container(
          margin: margin,
          height: getProportionateScreenHeight(335),
          width: getProportionateScreenWidth(335),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: PostImageItemThumbnail(
              postImageItem: postImageItems[0],
              onTap: () {
                open(context, 0);
              },
            ),
          ),
        );
        break;
      case 2:
        widget = Container(
          margin: margin,
          height: getProportionateScreenHeight(335),
          width: getProportionateScreenWidth(335),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const VerticalSpacing(of: 5),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[1],
                    onTap: () {
                      open(context, 1);
                    },
                  ),
                ),
              )
            ],
          ),
        );
        break;
      case 3:
        widget = Container(
          margin: margin,
          height: getProportionateScreenHeight(335),
          width: getProportionateScreenWidth(335),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const VerticalSpacing(of: 5),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5)),
                        child: PostImageItemThumbnail(
                          postImageItem: postImageItems[1],
                          onTap: () {
                            open(context, 1);
                          },
                        ),
                      ),
                    ),
                    const HorizontalSpacing(of: 5),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5)),
                        child: PostImageItemThumbnail(
                          postImageItem: postImageItems[2],
                          onTap: () {
                            open(context, 2);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
        break;
      default: //4개이상일 때 실행
        widget = Container(
          margin: margin,
          height: getProportionateScreenHeight(335),
          width: getProportionateScreenWidth(335),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const VerticalSpacing(of: 5),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5)),
                        child: PostImageItemThumbnail(
                          postImageItem: postImageItems[1],
                          onTap: () {
                            open(context, 1);
                          },
                        ),
                      ),
                    ),
                    const HorizontalSpacing(of: 5),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5)),
                        child: PostImageItemThumbnail(
                          hasMoreImg: true,
                          restImg: restImg,
                          postImageItem: postImageItems[2],
                          onTap: () {
                            open(context, 2);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
    }
    return widget;
  }
}

//파일 따로 빼야함1
// class PostImageItem {
//   PostImageItem({
//     required this.id,
//     required this.resource,
//   });

//   final String id;
//   final String resource;
// }

// class PostImageItemThumbnail extends StatelessWidget {
//   const PostImageItemThumbnail({
//     Key? key,
//     required this.postImageItem,
//     required this.onTap,

//   }) : super(key: key);

//   final PostImageItem postImageItem;

//   final GestureTapCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Hero(
//         tag: postImageItem.id,
//         child: Image.asset(
//           postImageItem.resource,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

// //여기는 나중에 파일을 따로 빼야할것같음2
// class GalleryPhotoViewWrapper extends StatefulWidget {
//   GalleryPhotoViewWrapper({
//     this.loadingBuilder,
//     this.backgroundDecoration,
//     this.minScale,
//     this.maxScale,
//     this.initialIndex = 0,
//     required this.galleryItems,
//     this.scrollDirection = Axis.horizontal,
//   }) : pageController = PageController(initialPage: initialIndex);

//   final LoadingBuilder? loadingBuilder;
//   final BoxDecoration? backgroundDecoration;
//   final dynamic minScale;
//   final dynamic maxScale;
//   final int initialIndex;
//   final PageController pageController;
//   final List<PostImageItem> galleryItems;
//   final Axis scrollDirection;

//   @override
//   State<StatefulWidget> createState() {
//     return _GalleryPhotoViewWrapperState();
//   }
// }

// class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
//   late int currentIndex = widget.initialIndex;

//   void onPageChanged(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Colors.black,
//       // ),
//       backgroundColor: Colors.black,
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           PhotoViewGallery.builder(
//             scrollPhysics: const BouncingScrollPhysics(),
//             builder: _buildItem,
//             itemCount: widget.galleryItems.length,
//             loadingBuilder: widget.loadingBuilder,
//             //backgroundDecoration: widget.backgroundDecoration,
//             pageController: widget.pageController,
//             onPageChanged: onPageChanged,
//             scrollDirection: widget.scrollDirection,
//           ),
//           Positioned(
//             bottom: 25,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: Indicators(widget.galleryItems.length, currentIndex)),
//           ),
//           Positioned(
//             top: 50,
//             right: 5,
//             child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(
//                   Icons.close,
//                   color: Colors.white,
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> Indicators(imagesLength, currentIndex) {
//     return List<Widget>.generate(imagesLength, (index) {
//       return Container(
//         margin: const EdgeInsets.all(3),
//         width: 10,
//         height: 10,
//         decoration: BoxDecoration(
//             color: currentIndex == index ? Colors.white : Colors.grey,
//             shape: BoxShape.circle),
//       );
//     });
//   }

//   PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
//     final PostImageItem item = widget.galleryItems[index];
//     return PhotoViewGalleryPageOptions(
//       imageProvider: AssetImage(item.resource),
//       initialScale: PhotoViewComputedScale.contained,
//       minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
//       maxScale: PhotoViewComputedScale.covered * 4.1,
//       heroAttributes: PhotoViewHeroAttributes(tag: item.id),
//     );
//   }
// }
