import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/utils/globals.dart';
import 'package:provider/provider.dart';

class NetworkTestConnectivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obter o status de conexão com o provider
    var connectionStatus = Provider.of<connectivityStatus>(context);

    if (connectionStatus == connectivityStatus.WIFI ||
        connectionStatus == connectivityStatus.PHONE) {
      return _animatedContainer(context, 0.0, 'Conectado!', Colors.green);
    }

    return _animatedContainer(context, 24.0, 'Sem conexão!', Colors.red);
  }

  _animatedContainer(context, sizeHeight, text, color) {
    return Material(
      child: AnimatedContainer(
        width: mediaQuery(context, 1),
        height: sizeHeight,
        duration: Duration(milliseconds: 1500),
        curve: Curves.fastOutSlowIn,
        child: Container(
          width: mediaQuery(context, 1),
          height: sizeHeight,
          color: color,
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
