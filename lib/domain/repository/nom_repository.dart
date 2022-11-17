import 'package:get_data_from_1c/domain/model/Nom.dart';

abstract class NomRepository {
  Future<Nom> getNomByBarcode(String inBarcode);
}
