import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';

import '../models/enums/interestStatus.dart';

class ProfileViewModel extends BaseModel {
  // final FriendService _friendService = serviceLocator<FriendService>();
  List<InterestPresentation> _interests = [];
 
}


/// user_profile과 일반 profile에서도 쓰임. 그리고 새로만든 user_profile_demand_survey에서도 쓰임
/// TODO: 이거 나중에 따로 빼야할듯 너무 연계된게 많음.. interestObject관련해서 살펴보기
class InterestPresentation {
  final String title;
  final InterestStatus status;

  InterestPresentation({required this.title, required this.status});
}
