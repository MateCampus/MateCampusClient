import 'package:zamongcampus/src/business_logic/models/interest.dart';

import '../../business_logic/models/enums/interestCode.dart';

abstract class InterestService {
  Future<List<Interest>> fetchMyInterests();
  Future<List<Interest>> updateMyInterests(
      List<InterestCode> selectInterestCodes);
}
