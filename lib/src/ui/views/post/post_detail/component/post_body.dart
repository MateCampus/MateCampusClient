import 'package:flutter/material.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(5),
                bottom: getProportionateScreenHeight(20)),
            child: Text(
              vm.postDetail.body,
              style: kPostBodyStyle,
            ),
          ),
        ),
        vm.postDetail.imageUrls.isEmpty
            ? const SizedBox()
            : Padding(
                padding:
                    EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
                child: _hasImage(context),
              ),
      ],
    );
  }

  Widget _hasImage(BuildContext context) {
    Widget widget;
    int restImg = vm.postDetail.imageUrls.length - 3;
    double entireWidth = getProportionateScreenWidth(335);
    double entireHeight = getProportionateScreenHeight(204);
    double tornPhotoWidth = getProportionateScreenWidth(101);
    double tornPhotoHeight = getProportionateScreenHeight(101);

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
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
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
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
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
              SizedBox(
                height: entireHeight,
                width: getProportionateScreenWidth(232),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: tornPhotoHeight,
                    width: tornPhotoWidth,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: PostImageItemThumbnail(
                        postImageItem: postImageItems[1],
                        onTap: () {
                          open(context, 1);
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: tornPhotoHeight,
                    width: tornPhotoWidth,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: PostImageItemThumbnail(
                        postImageItem: postImageItems[2],
                        onTap: () {
                          open(context, 2);
                        },
                      ),
                    ),
                  ),
                ],
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
              SizedBox(
                height: entireHeight,
                width: getProportionateScreenWidth(232),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: PostImageItemThumbnail(
                    postImageItem: postImageItems[0],
                    onTap: () {
                      open(context, 0);
                    },
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: tornPhotoHeight,
                    width: tornPhotoWidth,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: PostImageItemThumbnail(
                        postImageItem: postImageItems[1],
                        onTap: () {
                          open(context, 1);
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: tornPhotoHeight,
                    width: tornPhotoWidth,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
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
              )
            ],
          ),
        );
    }
    return widget;
  }
}
