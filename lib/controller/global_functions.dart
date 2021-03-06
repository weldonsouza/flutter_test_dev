import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

String validateEmail(email) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (email.length == 0) {
    return null;
  } else if(!regExp.hasMatch(email)){
    return "Email inválido";
  } else {
    return null;
  }
}

String validatePassword(password) {
  if (password.isEmpty) {
    return null;
  } else if(password.length < 8){
    return 'Sua senha deve ter mais de 8 caracteres.';
  }

  return null;
}

String validateTitle(value) {
  if (value.isEmpty) {
    return null;
  } else if(value.length < 3){
    return 'Seu titulo deve ter mais de 3 caracteres.';
  }

  return null;
}

String validateDescription(value) {
  if (value.isEmpty) {
    return null;
  } else if(value.length < 5){
    return 'Seu descrição deve ter mais de 5 caracteres.';
  }

  return null;
}

///------------------------ Função de requisições globais ----------------------
//Função gernerica de requisições
makeRequest(url, type, {context, body, headers}) async {
  var response;

  try {
    switch (type) {
      case typeRequest.GET:
        response = await http.get(url).timeout(Duration(seconds: 5));
        break;
      case typeRequest.POST:
        response = await http
            .post(url, body: body)
            .timeout(Duration(seconds: 5));
        break;
      case typeRequest.PUT:
        response = await http.put(url).timeout(Duration(seconds: 5));
        break;
      case typeRequest.DELETE:
        response = await http.put(url).timeout(Duration(seconds: 5));
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
