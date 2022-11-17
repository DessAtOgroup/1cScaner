class ApiNom {
  late String name;
  late String artikul;
  late String barcode;

  late List<dynamic> saldo;

  ApiNom() {
    name = '';
    artikul = '';
    barcode = '';
    saldo = [];
  }

  ApiNom.fromApi(Map<String, dynamic> map) // iNITIALIZER LIST
      : artikul = map['Артикул'] ?? "",
        name = map['Наименование'] ?? "",
        barcode = map['ШтриховойКод'] ?? "",
        saldo = map['Остатки'] ?? [];
}
