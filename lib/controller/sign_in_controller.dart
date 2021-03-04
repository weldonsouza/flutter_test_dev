import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/main.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/home/home_page.dart';

final formKey = GlobalKey<FormState>();
final scaffoldKeyLogin = GlobalKey<ScaffoldState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

final FocusNode loginFocus = FocusNode();
final FocusNode passwordFocus = FocusNode();

bool boolButton = true;

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
  } else {
    return null;
  }
}

//Verificar se o formulario esta completo
onTapLogin(context) async {
  if (formKey.currentState.validate()) {
    streamIsLoadingLogin.sink.add(true);
    _signInWithEmailAndPassword(context);
  } else if(emailController.text.isEmpty || passwordController.text.isEmpty) {
    streamIsLoadingLogin.sink.add(false);
  } else {
    onMSG(scaffoldKeyLogin , 'Usuário ou senha incorretos!');
    streamIsLoadingLogin.sink.add(false);
  }
}

_signInWithEmailAndPassword(context) async {
  try{
    final FirebaseUser user = (await auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).timeout(Duration(seconds: 5)).catchError((error, stackTrace) {})).user;

    streamIsLoadingLogin.sink.add(false);

    if (user != null) {
      onMSG(scaffoldKeyLogin , 'Conectado com sucesso! ${user.email}');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
      );

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