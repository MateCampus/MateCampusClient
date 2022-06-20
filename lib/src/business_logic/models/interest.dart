import 'enums/interestCode.dart';

class Interest {
  final InterestCode codeNum;

  Interest({required this.codeNum});

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
        codeNum:
            InterestCode.values.byName(json["interestCode"].toLowerCase()));
  }
}
