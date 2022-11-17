import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'barcode_scan_event.dart';
part 'barcode_scan_state.dart';

class BarcodeScanBloc extends Bloc<BarcodeScanEvent, BarcodeScanState> {
  BarcodeScanBloc() : super(BarcodeScanInitial()) {
    on<BarcodeScanPressed>(_onScanPressed);
    on<BarcodeScanEnded>(_onScanEnded);
    on<BarcodeDataFetched>(_onDataFetched);
    on<BarcodeSettingsEnter>(_onSettingsEnter);
    on<SetInitial>(_onSetInitial);
  }
}

void _onScanPressed(BarcodeScanEvent event, Emitter<BarcodeScanState> emit) {
  emit(BarcodeScanScanning());
}

void _onSetInitial(BarcodeScanEvent event, Emitter<BarcodeScanState> emit) {
  emit(BarcodeScanInitial());
}

void _onSettingsEnter(BarcodeScanEvent event, Emitter<BarcodeScanState> emit) {
  emit(BarcodeScanSettings());
}

void _onScanEnded(BarcodeScanEnded event, Emitter<BarcodeScanState> emit) {
  if (event.barcode == '-1') {
    emit(BarcodeScanCancelled());
    return;
  }
  if (event.barcode == 'Unknown') {
    emit(BarcodeScanGoneBad());
    return;
  }

  emit(BarcodeScanFetchingData());
}

void _onDataFetched(BarcodeDataFetched event, Emitter<BarcodeScanState> emit) {
  if (event._nomEmpty) {
    emit(BarcodeScanFetchingFailed());
  } else {
    emit(BarcodeScanWaiting());
  }
}
