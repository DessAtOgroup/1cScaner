

import 'package:get_data_from_1c/data/repository/authdata_data_repository.dart';
import 'package:get_data_from_1c/internal/dependencies/api_module.dart';



class AuthDataModule {
  static AuthDataDataRepository? _authDataRepository;
  static AuthDataDataRepository authDataRepository() {
    return _authDataRepository ??= AuthDataDataRepository(ApiModule.apiUtil());
  }
}
