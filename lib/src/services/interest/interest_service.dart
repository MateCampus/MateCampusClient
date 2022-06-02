import 'package:zamongcampus/src/business_logic/models/interest.dart';

import '../../business_logic/utils/interest_data.dart';

abstract class InterestService {
  Future<List<Interest>> fetchMyInterests();
  Future<List<Interest>> updateMyInterests(
      List<InterestCode> selectInterestCodes);
}
