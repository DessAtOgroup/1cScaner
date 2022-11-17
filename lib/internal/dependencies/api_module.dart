import 'package:get_data_from_1c/data/api/api_util.dart';
import 'package:get_data_from_1c/data/api/service/one_ess.dart';

class ApiModule {
  static ApiUtil? _apiUtil;
  static apiUtil() {
    _apiUtil ??= ApiUtil(OneEss());

    return _apiUtil;
  }
}
