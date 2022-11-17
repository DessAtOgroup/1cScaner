import 'package:get_data_from_1c/data/api/model/api_auth_data.dart';
import 'package:get_data_from_1c/domain/model/AuthData.dart';

class AuthDataMapper {
  static AuthData fromApi(ApiAuthData inApiAuthData) {
    return AuthData(inApiAuthData.serverAdress, inApiAuthData.login,
        inApiAuthData.password);
  }

  static ApiAuthData toApi(AuthData inAuthData) {
    return ApiAuthData(
        inAuthData.serverAdress, inAuthData.login, inAuthData.password);
  }
}
