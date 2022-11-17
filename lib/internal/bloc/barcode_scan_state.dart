part of 'barcode_scan_bloc.dart';

@immutable
abstract class BarcodeScanState {}

class BarcodeScanInitial extends BarcodeScanState {
  BarcodeScanInitial();
}

class BarcodeScanScanning extends BarcodeScanState {
  BarcodeScanScanning();
}

class BarcodeScanCancelled extends BarcodeScanState {
  BarcodeScanCancelled();
}

class BarcodeScanGoneBad extends BarcodeScanState {
  BarcodeScanGoneBad();
}

class BarcodeScanFetchingData extends BarcodeScanState {
  BarcodeScanFetchingData();
}

class BarcodeScanFetchingFailed extends BarcodeScanState {
  BarcodeScanFetchingFailed();
}

class BarcodeScanWaiting extends BarcodeScanState {
  BarcodeScanWaiting();
}

class BarcodeScanSettings extends BarcodeScanState {
  BarcodeScanSettings();
}
