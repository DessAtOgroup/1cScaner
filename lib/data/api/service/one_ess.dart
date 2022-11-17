import 'package:dio/dio.dart';
import 'package:get_data_from_1c/data/api/model/api_auth_data.dart';
import 'package:get_data_from_1c/data/api/model/api_nom.dart';
import 'package:get_data_from_1c/data/api/request/get_nom_body.dart';
import 'dart:convert';

import 'package:get_data_from_1c/data/api/service/local_data.dart';

class OneEss {
  int theLastStatus = 0;

  final Dio _dio = Dio(BaseOptions());
  Future<ApiNom> getNom(GetNomBody body, ApiAuthData localAuthData) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["Authorization"] =
        "Basic ${base64Url.encode(utf8.encode('${localAuthData.login}:${localAuthData.password}'))}";
    try {
      final response = await _dio.get(
        '${localAuthData.serverAdress}/${body.barcode}',
      );

      theLastStatus = response.statusCode ?? 0;
      Map<String, dynamic> map = Map<String, dynamic>();
      if (response.data != "null") {
        map = jsonDecode(response.data);
      }

      return ApiNom.fromApi(map);
    } catch (e) {
      return ApiNom();
    }
  }
}
