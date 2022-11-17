import 'package:get_data_from_1c/data/api/api_util.dart';
import 'package:get_data_from_1c/domain/model/Nom.dart';
import 'package:get_data_from_1c/domain/repository/nom_repository.dart';

class NomDataRepository extends NomRepository {
  final ApiUtil _apiUtil;

  NomDataRepository(this._apiUtil);

  @override
  Future<Nom> getNomByBarcode(String inBarcode) async {
    return _apiUtil.getNomByBarcode(inBarcode: inBarcode);
  }
}
