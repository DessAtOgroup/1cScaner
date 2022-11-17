import 'dart:convert';

import 'package:get_data_from_1c/data/api/model/api_auth_data.dart';
import 'package:get_data_from_1c/domain/model/AuthData.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LocalData {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/HakkiAuthData.txt');
  }

  Future<ApiAuthData> getAuthData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      Map map = jsonDecode(contents);

      return ApiAuthData(
          map['ServerAdress'] ?? '', map['Login'] ?? '', map['Password'] ?? '');
    } catch (error) {
      print(
          'foo, i made a poo'); //TODO Реализовать внятную систему вывода сообщений об ошибках
      return ApiAuthData('', '', '');
    }
  }

  Future<bool> setAuthData(ApiAuthData inApiAuthData) async {
    print('we are here');
    try {
      final file = await _localFile;

      String jsonStr = jsonEncode({
        'ServerAdress': inApiAuthData.serverAdress,
        'Login': inApiAuthData.login,
        'Password': inApiAuthData.password
      });
      File writedFile = await file.writeAsString(jsonStr);
      return true;
    } catch (error) {
      print('foo, i made a poo');
      return false;
    }
  }
}
