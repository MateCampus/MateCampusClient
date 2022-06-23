import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';

import 'base_model.dart';

class PostCreateScreenViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();

  final titleTextController = TextEditingController();
  final _bodyTextController = TextEditingController();
  TextEditingController get bodyTextController => _bodyTextController;

  final postFocusNode = FocusNode();

  List<XFile> pickedImgs = List.empty(growable: true);
  List<String> categoryCodeList = List.empty(growable: true);
  final ImagePicker picker = ImagePicker();

  void detectTextController() {
    _bodyTextController.addListener(() {
      notifyListeners();
    });
  }

  void createPost(BuildContext context) async {
    postFocusNode.unfocus();
    buildShowDialogForLoading(context: context);
    if (titleTextController.text.length < 5 &&
        _bodyTextController.text.length < 5) {
      Navigator.pop(context);
      toastMessage("글자수가 적습니다");
      return;
    }
    bool isCreated = await _postService.createPost(
        title: titleTextController.text,
        body: _bodyTextController.text,
        imageFileList: pickedImgs,
        categoryCodeList: categoryCodeList);
    if (isCreated) {
      toastMessage("게시물이 생성되었습니다!");
    } else {
      toastMessage("오류");
    }
    Navigator.popUntil(context, ModalRoute.withName('/'));
    PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();
    postMainScreenViewModel.refreshPostAfterCreateUpdate();
  }

  //갤러리에서 이미지 가져오는 함수
  void getImageFromGallery(BuildContext context) async {
    if (pickedImgs.length >= 10) {
      buildDialogForNotice(
          context: context, description: '사진은 최대 10장까지 올릴 수 있어요');
    } else {
      final List<XFile>? images = await picker.pickMultiImage();
      if (images != null) {
        if (images.length + pickedImgs.length > 10) {
          int remain = 10 - pickedImgs.length;
          pickedImgs.addAll(images.getRange(0, remain));
          buildDialogForNotice(
              context: context, description: '사진은 최대 10장까지 올릴 수 있어요');
        } else if (images.length + pickedImgs.length <= 10) {
          pickedImgs.addAll(images);
        }
      }
    }

    notifyListeners();
  }

  //카메라에서 이미지 가져오는 함수
  void getImageFromCamera(BuildContext context) async {
    if (pickedImgs.length >= 10) {
      buildDialogForNotice(
          context: context, description: '사진은 최대 10장까지 올릴 수 있어요');
    } else {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedImgs.add(image);
      }
    }
    notifyListeners();
  }

  void changecategoryCodeList(String categoryCodeName) {
    categoryCodeName = categoryCodeName.split('.').last;
    if (categoryCodeList.contains(categoryCodeName)) {
      categoryCodeList.remove(categoryCodeName);
    } else {
      if (categoryCodeList.length >= 3) {
        toastMessage("카테고리는 최대 3개까지입니다.");
        return;
      }
      categoryCodeList.add(categoryCodeName);
    }
    notifyListeners();
  }

  //이미지 삭제 함수
  void removeImage(int index) {
    pickedImgs.removeAt(index);
    notifyListeners();
  }

  void unfocusKeyboard() {
    if (postFocusNode.hasFocus) {
      postFocusNode.unfocus();
    }
  }
}
