import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import '../../business_logic/models/post.dart';
import 'post_service.dart';

class FakePostService implements PostService {
  @override
  Future<List<Post>> fetchPosts(
      {required String type, required int nextPageToken}) async {
    List<Post> list = [];
    list.add(Post(
        id: 1,
        loginId: "sye",
        categories: categoryDummy[Random().nextInt(2)],
        title: "제 이상형을 찾은것 같아요!",
        userNickname: "폼포코팡팡",
        body:
            "저는 묶은머리를 좋아해요. 뒷머리는 산뜻하게 묶고 옆머리는 흘러내리는 얼마전에 동기가 그 머리를 하고 왔어요. 완전 내 이상형",
        createdAt: DateTime(2022, 2, 3),
        likedCount: 874,
        viewCount: 3123,
        commentCount: 671,
        imageUrls: null));
    list.add(Post(
        id: 2,
        loginId: "zamong",
        categories: categoryDummy[Random().nextInt(2)],
        title: "줄서서 기다리는 단국대 맛집",
        userNickname: "자몽쟁이",
        body:
            "점심마다 메뉴가 고민된다면, 제가 먹어본 단국대 맛집을 소개합니다! 제가 입이 짧아서 맛집이라고 생각하는 곳이 잘 없는데 여기는 대박이에요",
        createdAt: DateTime(2022, 2, 13),
        likedCount: 789,
        viewCount: 2132,
        commentCount: 345,
        imageUrls: [
          "assets/images/event/event1.jpg",
          "assets/images/event/event2.jpg"
        ]));
    list.add(Post(
        id: 3,
        loginId: "suss",
        categories: categoryDummy[Random().nextInt(2)],
        title: "고양이들이 코 박고 자는 이유",
        userNickname: "미완성작품",
        body:
            "고양이들 코 시려우면 이런대ㅇㅇ 근데 추워서라기보단 흥분해서 코가 촉촉해지면 그러는거임. 너무 귀엽지 않니? 그런의미에서 우리 집 고양이 사진 올려두고감",
        createdAt: DateTime(2022, 1, 31),
        likedCount: 688,
        viewCount: 897,
        commentCount: 156,
        imageUrls: null));
    list.add(Post(
        id: 4,
        loginId: "sye",
        categories: categoryDummy[Random().nextInt(2)],
        title: "제 이상형을 찾은것 같아요!",
        userNickname: "폼포코팡팡",
        body:
            "저는 묶은머리를 좋아해요. 뒷머리는 산뜻하게 묶고 옆머리는 흘러내리는 얼마전에 동기가 그 머리를 하고 왔어요. 완전 내 이상형",
        createdAt: DateTime(2022, 2, 3),
        likedCount: 874,
        viewCount: 3123,
        commentCount: 671,
        imageUrls: [
          "assets/images/event/event1.jpg",
          "assets/images/event/event2.jpg"
        ]));
    list.add(Post(
        id: 5,
        loginId: "sye",
        categories: categoryDummy[Random().nextInt(2)],
        title: "제 이상형을 찾은것 같아요!",
        userNickname: "폼포코팡팡",
        body:
            "저는 묶은머리를 좋아해요. 뒷머리는 산뜻하게 묶고 옆머리는 흘러내리는 얼마전에 동기가 그 머리를 하고 왔어요. 완전 내 이상형",
        createdAt: DateTime(2022, 2, 3),
        likedCount: 874,
        viewCount: 3123,
        commentCount: 671,
        imageUrls: null));
    list.add(Post(
        id: 6,
        loginId: "sye",
        categories: categoryDummy[Random().nextInt(2)],
        title: "제 이상형을 찾은것 같아요!",
        userNickname: "폼포코팡팡",
        body:
            "저는 묶은머리를 좋아해요. 뒷머리는 산뜻하게 묶고 옆머리는 흘러내리는 얼마전에 동기가 그 머리를 하고 왔어요. 완전 내 이상형",
        createdAt: DateTime(2022, 2, 3),
        likedCount: 874,
        viewCount: 3123,
        commentCount: 671,
        imageUrls: null));
    return list;
  }
}
