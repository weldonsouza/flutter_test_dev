import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/controller/sign_in_controller.dart';
import 'package:flutter_test_dev/main.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/home/home_page.dart';

final formKeyRegister = GlobalKey<FormState>();
final scaffoldKeyRegister = GlobalKey<ScaffoldState>();
final TextEditingController emailControllerRegister = TextEditingController();
final TextEditingController passwordControllerRegister = TextEditingController();

final FocusNode emailFocusRegister = FocusNode();
final FocusNode passwordFocusRegister = FocusNode();

//Verificar se o formulario esta completo
onTapRegister(context) async {
  emailFocusRegister.unfocus();
  passwordFocusRegister.unfocus();

  if (formKeyRegister.currentState.validate()) {
    streamIsLoadingLogin.sink.add(true);
    _registerWithEmailAndPassword(context);
  } else if(emailControllerRegister.text.isEmpty || passwordControllerRegister.text.isEmpty) {
    streamIsLoadingLogin.sink.add(false);
  } else {
    onMSG(scaffoldKeyRegister , 'Usuário ou senha incorretos!');
    streamIsLoadingLogin.sink.add(false);
  }
}

_registerWithEmailAndPassword(context) async {
  try{
    final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
      email: emailControllerRegister.text,
      password: passwordControllerRegister.text,
    ).timeout(Duration(seconds: 5)).catchError((error, stackTrace) {})).user;

    streamIsLoadingLogin.sink.add(false);

    if (user != null) {
      onMSG(scaffoldKeyRegister , 'Cadastro realizado com sucesso! ${user.email}');

      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.of(context).pop();
      });

      emailControllerRegister.text = '';
      passwordControllerRegister.text = '';

    } else {
      onMSG(scaffoldKeyRegister , 'Falha ao realizar o cadastro.');
    }

  } on TimeoutException catch (e) {
    return null;
  } on Error catch (e) {
    streamIsLoadingLogin.sink.add(false);
    return null;
  } on SocketException catch (_) {
    return null;
  }
}