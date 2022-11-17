import 'package:flutter/material.dart';

import 'package:get_data_from_1c/domain/model/Nom.dart';
import 'dart:async';
import 'bloc/barcode_scan_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_data_from_1c/presentation/main_page.dart';

class Application extends StatelessWidget {
// Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
    // return MaterialApp(home: TestPage());
  }
}
