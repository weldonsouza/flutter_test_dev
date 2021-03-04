library my_prj.globals;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_dev/data/db_helper_base_pricing.dart';

//******************  CONSTANTES GLOBAIS  **********************
const String app = 'PRICING';

const String baseUrl = 'http://172.40.1.7:7904/rest/';

enum typeRequest {
  GET,
  POST,
  PUT,
  DELETE,
}

enum connectivityStatus {
  WIFI,
  PHONE,
  OFFLINE
}

//******************  VARIÁVEIS GLOBAIS  ********************
var dbBase = DBHelperBase();

final streamConnection = StreamController.broadcast();
final streamIsLoadingLogin = StreamController<bool>.broadcast();

var colorLight = Colors.blueGrey[50];
var colorDark = Colors.blueGrey;
var colorBase = Colors.lightBlue;

