import 'package:flutter/cupertino.dart';

class Nom {
  String name;
  String artikul;
  String barcode;
  List<dynamic> saldo = [];
  Nom(this.name, this.artikul, this.barcode, this.saldo);
  bool isEmpty() {
    if (name == "") {
      return true;
    } else {
      return false;
    }
  }
}
