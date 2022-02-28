import 'base_model.dart';

class MainViewModel extends BaseModel {
  String? loginId;
  String? token;

  Future<void> setTokenAndLoginId(String token, String loginId) async {
    setBusy(true);
    this.loginId = loginId;
    this.token = token;
    setBusy(false);
  }
}
