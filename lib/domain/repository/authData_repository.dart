import 'package:get_data_from_1c/domain/model/AuthData.dart';

abstract class AuthDataRepository {
  Future<AuthData> getAuthData();
  Future<bool> setAuthData(AuthData authData);
}
