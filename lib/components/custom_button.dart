import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  String title;
  Widget widgetRoute;

  CustomButton(this.title, this.widgetRoute);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      width: mediaQuery(context, 1),
      height: 50,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              if (widget.widgetRoute != null){
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => widget.widgetRoute),
                );
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Center(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: mediaQuery(context, 0.04),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
