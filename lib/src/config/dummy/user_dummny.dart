import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'package:zamongcampus/src/business_logic/models/enums/interestCode.dart';
import 'package:zamongcampus/src/business_logic/models/enums/majorCode.dart';
import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';

List<User> userDummy = [
  User(
      loginId: "zm1",
      nickname: "가나초코릿",
      collegeCode: CollegeCode.college0001,
      imageUrl: "assets/images/user/user1.jpg",
      majorCode: MajorCode.major0001,
      introduction: "자기개발, 꾸준함, 성실한 사람 좋아해요\n저랑 잘 맞는 친구 찾구싶어요!",
      isOnline: true,
      interests: [
        Interest(codeNum: InterestCode.interest0001),
        Interest(codeNum: InterestCode.interest0004),
        Interest(codeNum: InterestCode.interest0006)
      ]),
  const User(
      loginId: "zm2",
      nickname: "나비야훨훨",
      collegeCode: CollegeCode.college0002,
      imageUrl: null,
      majorCode: MajorCode.major0002,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm3",
      nickname: "다부지",
      collegeCode: CollegeCode.college0003,
      imageUrl: "assets/images/user/user3.jpg",
      majorCode: MajorCode.major0003,
      isOnline: null,
      interests: []),
  const User(
      loginId: "zm4",
      nickname: "라디오꾼",
      collegeCode: CollegeCode.college0004,
      imageUrl: "assets/images/user/user4.jpg",
      majorCode: MajorCode.major0004,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm5",
      nickname: "마라탕궈",
      collegeCode: CollegeCode.college0005,
      imageUrl: "assets/images/user/user5.jpg",
      majorCode: MajorCode.major0005,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm6",
      nickname: "나비야훨훨",
      collegeCode: CollegeCode.college0002,
      imageUrl: null,
      majorCode: MajorCode.major0002,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm7",
      nickname: "다부지",
      collegeCode: CollegeCode.college0003,
      imageUrl: "assets/images/user/user1.jpg",
      majorCode: MajorCode.major0003,
      isOnline: null,
      interests: []),
  const User(
      loginId: "zm8",
      nickname: "라디오꾼",
      collegeCode: CollegeCode.college0004,
      imageUrl: "assets/images/user/user4.jpg",
      majorCode: MajorCode.major0004,
      isOnline: false,
      interests: []),
  const User(
      loginId: "zm9",
      nickname: "마라탕궈",
      collegeCode: CollegeCode.college0005,
      imageUrl: "assets/images/user/user5.jpg",
      majorCode: MajorCode.major0005,
      isOnline: false,
      interests: []),
];

List<User> userDummy2 = [
  const User(
      loginId: "zm10",
      nickname: "바나나2",
      collegeCode: CollegeCode.college0001,
      imageUrl: "assets/images/user/user1.jpg",
      majorCode: MajorCode.major0001,
      isOnline: true,
      interests: []),
  const User(
      loginId: "zm11",
      nickname: "사이다",
      collegeCode: CollegeCode.college0002,
      imageUrl: "assets/images/user/user2.jpg",
      majorCode: MajorCode.major0002,
      isOnline: true,
      interests: []),
];

//좋아요리스트 용 유저더미
List<User> userDummyLikedPost = [
  const User(
    loginId: "zm10",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0001,
    majorCode: MajorCode.major0001,
    imageUrl: "assets/images/user/user1.jpg",
  ),
  const User(
    loginId: "zm11",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0002,
    majorCode: MajorCode.major0002,
    imageUrl: "assets/images/user/user2.jpg",
  ),
  const User(
    loginId: "zm12",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0003,
    majorCode: MajorCode.major0003,
    imageUrl: "assets/images/user/user3.jpg",
  ),
  const User(
    loginId: "zm13",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0004,
    majorCode: MajorCode.major0004,
    imageUrl: "assets/images/user/user4.jpg",
  ),
  const User(
    loginId: "zm14",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0005,
    majorCode: MajorCode.major0005,
    imageUrl: "assets/images/user/user5.jpg",
  ),
  const User(
    loginId: "zm10",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0001,
    majorCode: MajorCode.major0001,
    imageUrl: "assets/images/user/user1.jpg",
  ),
  const User(
    loginId: "zm11",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0002,
    majorCode: MajorCode.major0002,
    imageUrl: "assets/images/user/user2.jpg",
  ),
  const User(
    loginId: "zm12",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0003,
    majorCode: MajorCode.major0003,
    imageUrl: "assets/images/user/user3.jpg",
  ),
  const User(
    loginId: "zm13",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0004,
    majorCode: MajorCode.major0004,
    imageUrl: "assets/images/user/user4.jpg",
  ),
  const User(
    loginId: "zm14",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0005,
    majorCode: MajorCode.major0005,
    imageUrl: "assets/images/user/user5.jpg",
  ),
  const User(
    loginId: "zm10",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0001,
    majorCode: MajorCode.major0001,
    imageUrl: "assets/images/user/user1.jpg",
  ),
  const User(
    loginId: "zm11",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0002,
    majorCode: MajorCode.major0002,
    imageUrl: "assets/images/user/user2.jpg",
  ),
  const User(
    loginId: "zm12",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0003,
    majorCode: MajorCode.major0003,
    imageUrl: "assets/images/user/user3.jpg",
  ),
  const User(
    loginId: "zm13",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0004,
    majorCode: MajorCode.major0004,
    imageUrl: "assets/images/user/user4.jpg",
  ),
  const User(
    loginId: "zm14",
    nickname: "가랑비",
    collegeCode: CollegeCode.college0005,
    majorCode: MajorCode.major0005,
    imageUrl: "assets/images/user/user5.jpg",
  ),
];
