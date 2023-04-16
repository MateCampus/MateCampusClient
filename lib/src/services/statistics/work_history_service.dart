import 'package:zamongcampus/src/business_logic/models/enums/functionType.dart';
import 'package:zamongcampus/src/business_logic/models/enums/workType.dart';

abstract class WorkHistoryService {
  Future<void> sendWorkHistory(
      {required WorkType workType, required FunctionType functionType});
}
