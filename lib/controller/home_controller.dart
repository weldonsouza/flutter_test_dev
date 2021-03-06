import 'dart:convert';

import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/model/json_placeholder.dart';
import 'package:flutter_test_dev/utils/globals.dart';

List<dynamic> getBase = [];
List<dynamic> _dataGet = [];
List<JsonPlaceholder> dataJson = [];

//Atualizar a lista das coletas salvas no sqlite
getListTaskDB() async {
  getBase = await dbBase.getBaseDB();
}

//Consumimdo API externa do JsonPlaceholder
Future<List<dynamic>> getJson() async {
  var response = await makeRequest(baseUrl, typeRequest.GET);

  _dataGet = json.decode(response);

  for (int i = 0; i < _dataGet.length; i++) {
    if (_dataGet[i]['userId'] == 1) {
      dataJson.add(
        JsonPlaceholder(
          userId: _dataGet[i]['userId'],
          id: _dataGet[i]['id'],
          title: _dataGet[i]['title'],
          completed: _dataGet[i]['completed'],
        ),
      );
    }
  }

  streamJsonController.add(dataJson);

  return _dataGet;
}
