import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';

class Interest {
  final InterestCode codeNum;

  Interest({required this.codeNum});

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
        codeNum:
            InterestCode.values.byName(json["interestCode"].toLowerCase()));
  }
}
