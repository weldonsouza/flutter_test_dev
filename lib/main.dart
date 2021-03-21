import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_dev/services/connectivity_service.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:flutter_test_dev/view/login/sign_in.dart';
import 'package:provider/provider.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<connectivityStatus>(
          create: (context) =>
          ConnectivityService().connectionStatusController.stream,
          catchError: (BuildContext context, e) {
            return null;
          },
          updateShouldNotify: (_, __) => true,
        ),
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

