import 'package:get_data_from_1c/data/api/api_util.dart';
import 'package:get_data_from_1c/data/repository/nom_data_repository.dart';
import 'package:get_data_from_1c/domain/model/Nom.dart';
import 'package:get_data_from_1c/domain/repository/nom_repository.dart';
import 'package:get_data_from_1c/internal/dependencies/api_module.dart';

class NomRepositoryModule {
  static NomRepository? _nom;
  static NomRepository nomRepository() {
    return _nom ??= NomDataRepository(ApiModule.apiUtil());
  }
}
