part of 'barcode_scan_bloc.dart';

@immutable
abstract class BarcodeScanEvent {}

class InitialBarcodeEvent {}

class SetInitial extends BarcodeScanEvent {
  SetInitial();
}

class BarcodeScanPressed extends BarcodeScanEvent {
  BarcodeScanPressed();
}

class BarcodeScanEnded extends BarcodeScanEvent {
  String? barcode;

  BarcodeScanEnded(this.barcode);
}

class BarcodeDataFetched extends BarcodeScanEvent {
  bool _nomEmpty;
  BarcodeDataFetched(this._nomEmpty);
}

class BarcodeSettingsEnter extends BarcodeScanEvent {
  BarcodeSettingsEnter();
}
