import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_dev/view/login/sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('pt', 'BR') // Portuguese
      ],
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SignIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}

