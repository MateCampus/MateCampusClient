import 'package:zamongcampus/src/business_logic/models/interest.dart';

import '../../business_logic/utils/interest_data.dart';

abstract class InterestService {
  Future<List<Interest>> fetchMyInterests();
  Future<int> updateMyInterests(List<InterestCode> selectInterestCodes);
}
