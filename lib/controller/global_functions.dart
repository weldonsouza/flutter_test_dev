import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_test_dev/utils/globals.dart';

///------------------------------ Funções gerais -------------------------------
//Função generica para calcular o tamanho da tela
mediaQuery(BuildContext context, double value, {String direction}) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  direction = direction ?? 'H';
  Size size = mediaQuery.size;
  if (direction.toUpperCase() == 'H') {
    return size.width * value;
  } else {
    return size.height * value;
  }
}

//SnackBar
onMSG(scaffoldKey, msg) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(seconds: 3),
  ));
}

///------------------------ Função de requisições globais ----------------------
//Função gernerica de requisições
makeRequest(url, type, {context, body, headers}) async {
  var response;

  try {
    switch (type) {
      case typeRequest.GET:
        response = await http.get('$baseUrl$url').timeout(Duration(seconds: 5));
        break;
      case typeRequest.POST:
        response = await http
            .post('$baseUrl$url', body: body)
            .timeout(Duration(seconds: 5));
        break;
      case typeRequest.PUT:
        response = await http.put('$baseUrl$url').timeout(Duration(seconds: 5));
        break;
      case typeRequest.DELETE:
        response = await http.put('$baseUrl$url').timeout(Duration(seconds: 5));
        break;
    }

    return response.body;
  } on TimeoutException catch (e) {
    return null;
  } on Error catch (e) {
    return null;
  } on SocketException catch (_) {
    return null;
  }
}

///--------------------- Função para salvar dados no SQLite --------------------

///----------------------------- Provider Global -------------------------------
class GlobalProviderController with ChangeNotifier {
/*  //Variáveis utilizadas no Provider
  String _email;

  getControllerEmail() => _email;

  //Receber dados do email
  changeEmail(String value) {
    _email = value;
    notifyListeners();
  }*/
}