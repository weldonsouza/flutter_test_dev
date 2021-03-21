import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_test_dev/utils/globals.dart';

class ConnectivityService {
  //Controlador público
  StreamController<connectivityStatus> connectionStatusController =
      StreamController<connectivityStatus>();

  ConnectivityService() {
    //Steam para mudar o status de conectividade
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //Obter mais informações, se precisar
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  //Conversor do enum
  connectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return connectivityStatus.PHONE;
      case ConnectivityResult.wifi:
        return connectivityStatus.WIFI;
      case ConnectivityResult.none:
        return connectivityStatus.OFFLINE;
      default:
        return connectivityStatus.OFFLINE;
    }
  }
}
