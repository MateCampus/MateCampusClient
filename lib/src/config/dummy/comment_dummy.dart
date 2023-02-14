import 'package:zamongcampus/src/business_logic/models/comment.dart';

List<Comment> commentDummy = [
  Comment(
      id: 1,
      loginId: "user1",
      userNickname: "댓글러1",
      userCollegeName: '뿅뿅대학교',
      userImageUrl: "assets/images/user/user3.jpg",
      body: "와 댓글 일빠다.이게 과연 줄이 넘어가면 어떻게 될까 제발 그냥 좀 됐으면 좋겠다 근데 얼마나 더 길게 써야할까?",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 0,
      children: nestedCommentDummy),
  Comment(
      id: 2,
      loginId: "hithere",
      userNickname: "댓글러2",
      userCollegeName: '뿅뿅대학교',
      userImageUrl: "assets/images/user/user2.jpg",
      body: "두번째 댓글~",
      createdAt: DateTime(2022, 3, 28),
      deleted: true,
      parentId: 0,
      children: []),
  Comment(
      id: 3,
      loginId: "lilly",
      userNickname: "댓글러3",
      userCollegeName: '뿅뿅대학교',
      userImageUrl: "",
      body: "세번째 메롱",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 0,
      children: [])
];

List<Comment> nestedCommentDummy = [
  Comment(
      id: 4,
      loginId: "asd",
      userNickname: "대댓글러1",
      userCollegeName: '뿅뿅대학교',
      userImageUrl: "",
      body: "와 대댓글 일빠다. 제발 됐으면 좋겠다",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 1,
      children: []),
  Comment(
      id: 5,
      loginId: "ohoh",
      userNickname: "대댓글러2",
     userCollegeName: '뿅뿅대학교',
      userImageUrl: "assets/images/user/user4.jpg",
      body: "윗 댓 나랑 학교 같다 신기행",
      createdAt: DateTime(2022, 3, 28),
      deleted: false,
      parentId: 1,
      children: []),
  Comment(
      id: 6,
      loginId: "li",
      userNickname: "대댓글러3",
      userCollegeName: '뿅뿅대학교',
      userImageUrl: "assets/images/user/user2.jpg",
      body: "세번째 메롱",
      createdAt: DateTime(2022, 3, 28),
      deleted: true,
      parentId: 1,
      children: [])
];
