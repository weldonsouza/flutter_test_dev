import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/main.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/home/home_page.dart';

final formKeyLogin = GlobalKey<FormState>();
final scaffoldKeyLogin = GlobalKey<ScaffoldState>();
final TextEditingController emailControllerLogin = TextEditingController();
final TextEditingController passwordControllerLogin = TextEditingController();

final FocusNode loginFocusLogin = FocusNode();
final FocusNode passwordFocusLogin = FocusNode();

//Verificar se o formulario esta completo
onTapLogin(context) async {
  if (formKeyLogin.currentState.validate()) {
    streamIsLoadingLogin.sink.add(true);
    _signInWithEmailAndPassword(context);
  } else if(emailControllerLogin.text.isEmpty || passwordControllerLogin.text.isEmpty) {
    streamIsLoadingLogin.sink.add(false);
  } else {
    onMSG(scaffoldKeyLogin , 'Usuário ou senha incorretos!');
    streamIsLoadingLogin.sink.add(false);
  }
}

_signInWithEmailAndPassword(context) async {
  try{
    final FirebaseUser user = (await auth.signInWithEmailAndPassword(
      email: emailControllerLogin.text,
      password: passwordControllerLogin.text,
    ).timeout(Duration(seconds: 5)).catchError((error, stackTrace) {})).user;

    streamIsLoadingLogin.sink.add(false);

    if (user != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
      );

      emailControllerLogin.text = '';
      passwordControllerLogin.text = '';

    } else {
      onMSG(scaffoldKeyLogin , 'Falha ao realizar autenticação.');
    }

  } on TimeoutException catch (e) {
    return null;
  } on Error catch (e) {
    streamIsLoadingLogin.sink.add(false);
    onMSG(scaffoldKeyLogin , 'Usuário ou senha incorretos!');
    return null;
  } on SocketException catch (_) {
    return null;
  }
}