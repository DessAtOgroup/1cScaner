import 'package:dio/dio.dart';
import 'package:get_data_from_1c/data/api/model/api_nom.dart';
import 'package:get_data_from_1c/data/api/request/get_nom_body.dart';

class TestService {
  Future<ApiNom> getNom(GetNomBody body) async {
    return ApiNom.fromApi({
      "Штрихкод": "2001000000012",
      "Номенклатура": "Вафли \"Венские\" с шоколадом",
      "Артикул": "null",
      "Остатки": [
        {"Склад": "Основной склад", "Остаток": 1100}
      ]
    });
  }
}
