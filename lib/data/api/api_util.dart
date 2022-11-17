import 'package:flutter/material.dart';
import 'package:get_data_from_1c/data/api/model/api_auth_data.dart';
import 'package:get_data_from_1c/data/api/service/local_data.dart';
import 'package:get_data_from_1c/data/api/service/one_ess.dart';
import 'package:get_data_from_1c/data/api/service/test_service.dart';
import 'package:get_data_from_1c/data/mapper/authdata_mapper.dart';
import 'package:get_data_from_1c/domain/model/Nom.dart';
import 'package:get_data_from_1c/data/api/request/get_nom_body.dart';
import 'package:get_data_from_1c/data/mapper/nom_mapper.dart';
import 'package:get_data_from_1c/domain/model/AuthData.dart';

class ApiUtil {
  //Единая точка входа в API для всех сервисов.
  final OneEss _oneAssService;
  LocalData _localDataService = LocalData();

  ApiUtil(this._oneAssService);
  //ApiUtil.test(this._testService);
  Future<AuthData> getAuthData() async {
    ApiAuthData _apiAuthData = await _localDataService.getAuthData();
    return AuthDataMapper.fromApi(_apiAuthData);
  }

  Future<bool> setAuthData(AuthData inAuthData) async {
    return LocalData().setAuthData(AuthDataMapper.toApi(inAuthData));
  }

  Future<Nom> getNomByBarcode({required String inBarcode}) async {
    final body = GetNomBody(barcode: inBarcode);
    final localData = await LocalData().getAuthData();
    final result = await _oneAssService.getNom(body, localData); //ApiNom
    return NomMapper.fromApi(result);
  }
}
