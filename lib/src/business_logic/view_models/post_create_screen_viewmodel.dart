import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';

import 'base_model.dart';

class PostCreateScreenViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();

  final titleTextController = TextEditingController();
  final bodyTextController = TextEditingController();

  bool isShowOnlySameUniv = false;
  List<XFile> pickedImgs = [];
  final ImagePicker picker = ImagePicker();

  void createPost(BuildContext context) async {
    if (titleTextController.text.length < 5 &&
        bodyTextController.text.length < 5) {
      toastMessage("글자수가 적습니다");
      return;
    }
    bool isCreated = await _postService.createPost(
        title: titleTextController.text,
        body: bodyTextController.text,
        imageFileList: pickedImgs);
    if (isCreated) {
      toastMessage("게시물이 생성되었습니다!");
    } else {
      toastMessage("오류");
    }
    Navigator.pop(context);
  }

  void changeIsShowOnlySameUniv() {
    isShowOnlySameUniv = !isShowOnlySameUniv;
  }

  //갤러리에서 이미지 가져오는 함수
  void getImageFromGallery() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      pickedImgs = images;
      notifyListeners();
    }
  }

  //카메라에서 이미지 가져오는 함수
  void getImageFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImgs.add(image);
      notifyListeners();
    }
  }

  //이미지 삭제 함수
  void removeImage(int index) {
    pickedImgs.removeAt(index);
    notifyListeners();
  }
}
