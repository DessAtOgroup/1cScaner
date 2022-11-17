import 'package:get_data_from_1c/domain/model/AuthData.dart';
import 'package:get_data_from_1c/domain/repository/authData_repository.dart';
import 'package:get_data_from_1c/data/api/api_util.dart';

class AuthDataDataRepository extends AuthDataRepository {
  final ApiUtil _apiUtil;

  AuthDataDataRepository(this._apiUtil);

  @override
  Future<AuthData> getAuthData() {
    return _apiUtil.getAuthData();
  }

  @override
  Future<bool> setAuthData(AuthData inAuthData) {
    return _apiUtil.setAuthData(inAuthData);
  }
}
