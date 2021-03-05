import 'package:flutter/material.dart';
import 'package:flutter_test_dev/controller/global_functions.dart';
import 'package:flutter_test_dev/controller/register_controller.dart';
import 'package:flutter_test_dev/controller/sign_in_controller.dart';
import 'package:flutter_test_dev/utils/globals.dart';

// ignore: must_be_immutable
class AnimatedButton extends StatefulWidget {
  String title;
  bool loading = false;

  AnimatedButton(this.title, this.loading);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1500),
      decoration: BoxDecoration(
        color: colorBase,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(widget.loading != false ? 100 : 10),
        border: Colors.white == null ? null : Border.all(color: colorBase),
      ),
      width: widget.loading != false ? 50 : mediaQuery(context, 1),
      height: 50,
      alignment: Alignment.center,
      curve: Curves.fastOutSlowIn,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.loading != false ? 100 : 10)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (){
              if(widget.title == 'REGISTRAR'){
                onTapRegister(context);
              } else {
                onTapLogin(context);
              }
            },
            child: Center(
              child: AnimatedCrossFade(
                duration: Duration(milliseconds: 500),
                firstChild: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuery(context, 0.04),
                  ),
                ),
                secondChild: Container(
                  margin: EdgeInsets.all(8),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ),
                crossFadeState: widget.loading != false
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
