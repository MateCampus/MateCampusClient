import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'package:zamongcampus/src/business_logic/models/enums/postCategoryCode.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/config/dummy/comment_dummy.dart';

List<Post> postMainTestDummy = [
  //사진 x, 카테고리 ㅇ, 유저프사 ㅇ
  Post(
      id: 1,
      loginId: "sye",
      postCategoryCodes: [
        PostCategoryCode.postcategory0001,
        PostCategoryCode.postcategory0004
      ],
      userNickname: "폼포코팡팡",
      userCollegeCode: CollegeCode.college0001,
      userImageUrl: "assets/images/user/user1.jpg",
      body:
          "저는 묶은머리를 좋아해요. 뒷머리는 산뜻하게 묶고 옆머리는 흘러내리는 그런 머리가 좋아요. 얼마전에 동기가 그 머리를 하고 왔어요. 평소와는 너무 다르게 보이고 그 후로 자꾸만 생각나는데 어떡하죠ㅜㅜㅜ",
      createdAt: DateTime(2022, 11, 1),
      likedCount: 11,
      viewCount: 3123,
      commentCount: 10,
      imageUrls: [],
      comments: []),

  //사진ㅇ, 카테고리ㅇ, 유저프사 ㄴ
  Post(
      //post detail fake data로 사용
      id: 2,
      loginId: "user1",
      postCategoryCodes: [
        PostCategoryCode.postcategory0002,
        PostCategoryCode.postcategory0006
      ],
      userNickname: "자몽쟁이",
      userCollegeCode: CollegeCode.college0003,
      userImageUrl: "",
      body:
          "서울 밖 외곽 쪽으로 나오면 용인에 위치해있는 단국대 죽전을 만나볼 수 있는데 특히 이곳에서도 유명하다고 불리는 맛집들이 있어서 학생들이 종종 찾아가는 편이야.\n\n그래서 오늘은 죽전에서 유명하다고 하는 단국대학교 맛집을 소개해보려고 해.",
      createdAt: DateTime(2022, 10, 31),
      likedCount: 20,
      viewCount: 2132,
      commentCount: 17,
      imageUrls: [
        "assets/images/event/event1.jpg",
        "assets/images/event/event2.jpg",
        "assets/images/event/event3.jpg",
        // "assets/images/event/event2.jpg",
        // "assets/images/event/event2.jpg",
      ],
      comments: commentDummy),
  //사진x, 카테고리 x, 유저프사 x,
  Post(
    id: 3,
    loginId: "suss",
    userNickname: "고양이집사",
    userCollegeCode: CollegeCode.college0005,
    userImageUrl: "",
    body:
        "고양이들 코 시려우면 이런대ㅇㅇ 근데 추워서라기보단 흥분해서 코가 촉촉해지면 그러는거임. 너무 귀엽지 않니? 그런의미에서 우리 집 고양이 사진 올려두고감",
    createdAt: DateTime(2022, 1, 31),
    likedCount: 688,
    viewCount: 897,
    commentCount: 156,
    imageUrls: [],
    comments: [],
  ),
];
