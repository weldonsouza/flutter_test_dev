import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/view/login/sign_in.dart';
import 'package:provider/provider.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProviderController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

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

