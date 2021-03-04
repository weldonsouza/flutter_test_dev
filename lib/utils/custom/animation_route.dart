import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';

class AnimationRoute extends ModalRoute<void> {
  String dataCollect;
  String branch;
  String codeProduct;
  String codeBar;
  double price;
  int idCompany;
  String urlImages;
  String latitude;
  String longitude;
  String dateSchedule;

  dynamic _dataPost = [];

  AnimationRoute(
      this.dataCollect,
      this.branch,
      this.codeProduct,
      this.codeBar,
      this.price,
      this.idCompany,
      this.urlImages,
      this.latitude,
      this.longitude,
      this.dateSchedule);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  Future _introPricing(context) async {
    /*var response = await makeRequest(
        'PRICING/GRCOLETAS',
        typeRequest.POST,
        body: '{'
            '"usuario" : "$codeResearcher",'
            '"dataColeta" : "$dataCollect",'
            '"filial" : "$branch",'
            '"codProduto" : "$codeProduct",'
            '"codBarras" : "$codeBar",'
            '"preco" : $price,'
            '"status" : "F",'
            '"precode" : 0,'
            '"precopor" : 0,'
            '"idEmpresa" : $idCompany,'
            '"urlImagens" : "$urlImages",'
            '"latitude" : "$latitude",'
            '"longitude" : "$longitude",'
            '"dataAgendamento" : "",'
            '"usrAgendamento" : "$codeResearcher"}',
      context: context
    );*/


    //_dataPost = json.decode(response);

    print('_dataPost $_dataPost');

    /*if(_dataPost[0]['success'] == true){
      Future.delayed(Duration(seconds: 1), (){
        getProductViewDel('', '', '', dateFormat, dateFormat, '', 'F', '', '');
        Navigator.of(context).pop();
        streamSearchFilter.add('');
      });
      onMSG(_scaffoldKey, 'Coleta adicionada com sucesso!');
    } else {
      Navigator.of(context).pop();
      alertCheck(context, title: 'Erro', subTitle: 'Verifique os dados!');
    }*/

    return _dataPost;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return FutureBuilder(
      future: _introPricing(context),
      builder: (context, snapshot) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
              Text(
                'Gravando...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
