import 'package:get_data_from_1c/domain/model/Nom.dart';
import 'package:get_data_from_1c/data/api/model/api_nom.dart';

class NomMapper {
  static Nom fromApi(ApiNom inApiNom) {
    return Nom(
        inApiNom.name, inApiNom.artikul, inApiNom.barcode, inApiNom.saldo);
  }
}
