import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/gallery_photo_view_wrapper.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/post_image_item_thumbnail.dart';

class PostBody extends StatelessWidget {
  final PostDetailScreenViewModel vm;

  const PostBody({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: vm.postDetail.imageUrls.isEmpty
                ? EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(5),
                    getProportionateScreenHeight(15),
                    getProportionateScreenWidth(5),
                    0)
                : EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(15),
                    horizontal: getProportionateScreenWidth(5)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                vm.postDetail.body,
                style: kPostBodyStyle,
              ),
            ),
          ),
          vm.postDetail.imageUrls.isEmpty
              ? const SizedBox(
                  height: 30,
                )
              : _hasImage(context),
        ],
      ),
    );
  }

  Widget _hasImage(BuildContext context) {
    Widget widget;
    int restImg = vm.postDetail.imageUrls.length - 3;
    double entireWidth = getProportionateScreenWidth(355);
    double entireHeight = getProportionateScreenHeight(265);

    List<ImageItem> postImageItems = <ImageItem>[];

    for (int i = 0; i < vm.postDetail.imageUrls.length; i++) {
      postImageItems
          .add(ImageItem(id: "tag${i}", resource: vm.postDetail.imageUrls[i]));
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

    switch (vm.postDetail.imageUrls.length) {
      case 1:
        widget = SizedBox(
          height: entireHeight,
          width: entireWidth,
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
        widget = SizedBox(
          height: entireHeight,
          width: entireWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const HorizontalSpacing(of: 3),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
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
        widget = SizedBox(
          height: entireHeight,
          width: entireWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const HorizontalSpacing(of: 3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5)),
                        child: PostImageItemThumbnail(
                          postImageItem: postImageItems[1],
                          onTap: () {
                            open(context, 1);
                          },
                        ),
                      ),
                    ),
                    const VerticalSpacing(of: 3),
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
        widget = SizedBox(
          height: entireHeight,
          width: entireWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const HorizontalSpacing(of: 3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5)),
                        child: PostImageItemThumbnail(
                          postImageItem: postImageItems[1],
                          onTap: () {
                            open(context, 1);
                          },
                        ),
                      ),
                    ),
                    const VerticalSpacing(of: 3),
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
