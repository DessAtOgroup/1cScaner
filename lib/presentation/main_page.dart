import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_data_from_1c/domain/model/AuthData.dart';
import 'package:get_data_from_1c/domain/model/Nom.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

import 'package:get_data_from_1c/domain/repository/authData_repository.dart';
import 'package:get_data_from_1c/domain/repository/nom_repository.dart';
import 'package:get_data_from_1c/internal/bloc/barcode_scan_bloc.dart';
import 'package:get_data_from_1c/internal/dependencies/Nomrepository_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_data_from_1c/internal/dependencies/api_module.dart';
import 'package:get_data_from_1c/internal/dependencies/authdata_module.dart';

List listOfTiles(List<dynamic> saldo) {
  List<Widget> result = [];
  saldo.forEach((element) => result.add(ListTile(
        title: Text(element["Склад"]),
        trailing: Text(element["Остаток"].toString()),
      )));

  return result;
}

class NomenclatureView extends StatelessWidget {
  Nom? nom;
  NomenclatureView({super.key, required this.nom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: (nom == null || nom?.saldo == null)
          ? const Text("")
          : Card(
              child: Column(children: [
              ListTile(
                  title: Text(
                nom?.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              ListTile(title: Text(nom?.artikul ?? "")),
              ...listOfTiles(nom!.saldo)
            ])),
    );
  }
}

class HakkiElevatedButton extends StatelessWidget {
  VoidCallback? onPressed;
  HakkiElevatedButton({this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color>(const Color(0xFFBDCE95)),
            foregroundColor: MaterialStateProperty.all(Color(0xFF3F472E)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        onPressed: onPressed,
        icon: Icon(Icons.qr_code_scanner),
        label: Text('Сканировать'));
  }
}

class HakkiInfoCard extends StatelessWidget {
  String? title, subtitle;
  final BarcodeScanState? state;
  final String? scannedBarcode;
  HakkiInfoCard({super.key, this.state, this.scannedBarcode}) {
    if (state is BarcodeScanInitial) {
      title = "Для получения данных - сканируйте штрихкод";
      subtitle = '';
    } else if (state is BarcodeScanGoneBad) {
      title = "Не удалось отсканировать штрихкод";
      subtitle = '';
    } else if (state is BarcodeScanCancelled) {
      title = 'Сканирование отменено';
      subtitle = '';
    } else if (state is BarcodeScanFetchingData) {
      title = "Успешно отсканирован штрихкод $scannedBarcode";
      subtitle = 'Выполняется получение данных...';
    } else if (state is BarcodeScanFetchingFailed) {
      title = "Успешно отсканирован штрихкод $scannedBarcode";
      subtitle = 'Не удалось получить данные с сервера 1С';
    } else if (state is BarcodeScanWaiting) {
      title = 'Успешно от сканирован штрихкод $scannedBarcode';
      subtitle = 'Данные по штрихкоду получены с сервера';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Color.fromRGBO(215, 220, 197, 1),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text('$title'),
                subtitle: Text('$subtitle'),
              ),
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}

class TestPage extends StatelessWidget {
  TestPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: HakkiInfoCard(),
    ));
  }
}

class MainPage extends StatelessWidget {
  Nom? nom;
  AuthData? authData = AuthData('', '', '');
  String scannedBarcode = "Unknown";
  TextEditingController serverAdressCntr = TextEditingController(),
      loginCntr = TextEditingController(),
      passwordCntr = TextEditingController();

  MainPage({super.key}) {
    getAuthData();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = "Unknown";
    }

    scannedBarcode = barcodeScanRes.replaceAll(" ", "");
  }

  Future<void> _dialogBuilder(BuildContext context) {
    InputDecoration inputDecoration = const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))));
    serverAdressCntr.text = authData!.serverAdress ?? '';
    loginCntr.text = authData!.login ?? '';
    passwordCntr.text = authData!.password ?? '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Настройки'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300.0),
            child: Column(
              children: [
                ListTile(
                  title: Text('Адрес сервера'),
                  subtitle: TextField(
                      controller: serverAdressCntr,
                      decoration: inputDecoration),
                ),
                ListTile(
                  title: Text('Логин'),
                  subtitle: TextField(
                      controller: loginCntr, decoration: inputDecoration),
                ),
                ListTile(
                  title: Text('Пароль'),
                  subtitle: TextField(
                      controller: passwordCntr, decoration: inputDecoration),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF3F472E),
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Сохранить'),
              onPressed: () {
                authData = AuthData(
                    serverAdressCntr.text, loginCntr.text, passwordCntr.text);
                setAuthData(authData!);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF3F472E),
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Отменить'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getNomData(String inBarcode) async {
    NomRepository nomRep = NomRepositoryModule.nomRepository();
    nom = await nomRep.getNomByBarcode(scannedBarcode);
  }

  Future<void> getAuthData() async {
    AuthDataRepository authDataRep = AuthDataModule.authDataRepository();
    authData = await authDataRep.getAuthData();
  }

  Future<void> setAuthData(AuthData inAuthData) async {
    AuthDataRepository authDataRep = AuthDataModule.authDataRepository();
    await authDataRep.setAuthData(inAuthData);
  }

  void showSettings(inCnt) async {
    inCnt.read<BarcodeScanBloc>().add(BarcodeScanSettings());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Builder(builder: (BuildContext context) {
      return BlocProvider(
          create: (context) => BarcodeScanBloc(),
          child: BlocBuilder<BarcodeScanBloc, BarcodeScanState>(
              builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/images/logoHakki.png"))
                  ],
                ),
                flexibleSpace: Image(
                  image: AssetImage('assets/images/top_panel.png'),
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.black),
                    tooltip: 'Настройки',
                    onPressed: () => _dialogBuilder(context),
                  ),
                ],
              ),
              body: Container(
                color: Color(0xFFF5F5F5),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    HakkiInfoCard(state: state, scannedBarcode: scannedBarcode),
                    Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        if (state is BarcodeScanWaiting) ...[
                          NomenclatureView(nom: nom),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
              floatingActionButton: HakkiElevatedButton(
                onPressed: () async {
                  // context.read<BarcodeScanBloc>().add(BarcodeScanPressed());
                  await scanBarcodeNormal();
                  if ((scannedBarcode == "-1") ||
                      (scannedBarcode == "Unknown")) {
                    context
                        .read<BarcodeScanBloc>()
                        .add(BarcodeScanEnded(scannedBarcode));
                    return;
                  }
                  // if ((state is BarcodeScanCancelled) ||
                  //     (state is BarcodeScanGoneBad)) return;

                  await getNomData(scannedBarcode);
                  bool isEmpty = (nom == null) || nom!.isEmpty();
                  context
                      .read<BarcodeScanBloc>()
                      .add(BarcodeDataFetched(isEmpty));
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            )
                // this

                ;
          }));
    }));
  }
}
